#!/usr/bin/perl 
#===============================================================================
#
#         FILE: lock_squid.pl
#
#        USAGE: ./lock_squid.pl  
#
#  DESCRIPTION: \
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR:  (), |whymaths@gmail.com|
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 09/10/2012 03:27:30 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Modern::Perl;

use FindBin;
use lib "$FindBin::Bin/../lib";

use strict;
use warnings;
use autodie;
use vars qw ($Debug);
use Furl;
use IO::File;
use Getopt::Long;

use IPC::Locker;
use IPC::PidStat;

#======================================================================

my $pscount = `ps aux|grep -v grep|grep $0|wc -l`;
print "Already run, waiting for lock now" and exit unless $pscount == 1;

#======================================================================

my %server_params = (lock=>[]);
my $cluserv;

$Debug = 0;
Getopt::Long::config ("require_order");
if (! GetOptions (
                  "dhost=s"     => sub {shift; $server_params{host} = shift;},
                  "cluster=s"   => sub {shift; push @{$server_params{lock}}, split(':',shift);},
                  "port=i"      => sub {shift; $server_params{port} = shift;},
                  "timeout=i"   => sub {shift; $server_params{timeout} = shift;},
                  "verbose!"    => sub {shift; $server_params{verbose} = shift;},
                  "debug"       => \&debug,
                  "service=s"   => \$cluserv,
                  )) {
    die "%Error: Bad usage, see lockersh --help\n";
}

$#{$server_params{lock}}>=0 or die "%Error: --cluster not specified; see lockersh --help\n";

# Fork once to start parent process
my $foreground_pid = $$;  # Unlike most forks, the job goes in the parent

# Do this while we still have STDERR.
my $lock  = new IPC::Locker (verbose=>0,
                             timeout=>0,
                             autounlock=>1,
                             destroy_unlock=>0,
                             %server_params,
                             );
$lock or die "%Error: Did not connect to lockerd,";
$lock->lock;

if (my $pid = fork()) {  # Parent process, foreground job
    print "\tForeground: $cluserv\n" if $Debug;
    # The child forks again quickly.  Sometimes, SIG_CHLD leaks to us and
    # wrecks the exec'd command, so wait for it now.
    my $rv = waitpid($pid, 0);
    if ($rv != $pid) {
        die "%Error: waitpid() returned $rv: $!";
    } elsif ($?) {
        die "%Error: Child process died with status $?,";
    }

    print "Exec in $$\n" if $Debug;
    &service($cluserv);
}
#else, rest is for child process.

# Disassociate from controlling terminal
POSIX::setsid() or die "%Error: Can't start a new session: $!";

# Change working directory
chdir "/";
open(STDIN,  "+>/dev/null") or die "%Error: Can't re-open STDIN: $!";
if (!$Debug) {
    open(STDOUT, "+>&STDIN");
    open(STDERR, "+>&STDIN");
}
# Prevent possibility of acquiring a controlling terminal
exit(0) if fork();

# Wait for child to complete.  We can't waitpid, as we're not the parent
while (IPC::PidStat::local_pid_exists($foreground_pid)) { sleep 1; }
print "Parent $foreground_pid completed\n" if $Debug;

# Unlock
$lock->unlock; $lock=undef;
print "Child exiting\n" if $Debug;

sub debug {
    $Debug = 1;
    $IPC::Locker::Debug = 1;
}

sub service {
    my $cluserv = shift;
    die "Only support squid now!" unless $cluserv eq "squid";
    die "Reload failed. Check squid.conf!" if eval "${cluserv}_reload";
    while (1) {
        my $hit_rate = eval "${cluserv}_check";
        notify "HIT Ratio: ${hit_rate}% now.\n";
        exit if $hit_rate > 50;
        sleep 300;
    };
}

sub squid_check {
    my $hit_rate;
    print "Run squid_check" if $Debug;
    my $squid_port = `awk '/^http_port/{print $2}' /etc/squid/squid.conf`;
    open my $fh, "squidclient -p ${squid_port} mgr:info |";
    while (<$fh>) {
        next unless /^\s+Request Hit Ratios:\s+5min:\s*(-?\d+\.\d)%,/;
        print "regex $1" if $Debug;
        $hit_rate = $1;
        last;
    }
    close $fh;
    return $hit_rate;
}

sub squid_reload {
    print "Reload squid daemon. Do not reload within 10 mins of squid start" if $Debug;
    system("squid", "-k", "reconfigure");
    return $?;
}

sub notify {
    my $furl = Furl->new(agent => "Clustrol/0.1");
    $furl->post("http://monitor.domain.com/eml/",
        [ data => "$_" ],
    );
}

__END__

