#!/usr/bin/env perl

use strict;
use warnings;

use Gearman::Worker;
use Storable qw( thaw store retrieve );
use List::Util qw( sum );

use POSIX qw(strftime getpid fork setsid);
use Carp qw(croak);


my $disk_an = "/opt/work/worker/disk";

use Getopt::Long;

$SIG{INT} = sub {
    unlink $disk_an;
    exit 1;
};

my (

    $daemonize,

);

GetOptions(
    "d|daemonize"    => \$daemonize,
);


daemonize() if $daemonize;


open my $ip_fd, "</opt/work/worker/me.ip" or die "open ip file error: $!";
my $ip;
while(<$ip_fd>) {
    $ip = $_;
    chomp $ip;
}



my $worker = Gearman::Worker->new;
$worker->job_servers('10.11.6.204', '192.168.12.155');

$worker->register_function( dfs => sub {
        open my $df_worker, ">>$disk_an" or die "open ip file error: $!";

        #store \{$_[0]->arg}, '/opt/work/disk.an';
        print $df_worker $_[0]->arg, "\n";
        print $_[0]->arg, "\n";
        close $df_worker if $df_worker;
    }
);

$worker->register_function(sum => sub {
        sum @{ thaw($_[0]->arg) }
    }
);

#$worker->work;
$worker->work while 1;


sub daemonize {
    my ($pid, $sess_id, $i);

    ## Fork and exit parent
    if ($pid = fork) { exit 0; }

    ## Detach ourselves from the terminal
    croak "Cannot detach from controlling terminal"
        unless $sess_id = POSIX::setsid();

    ## Prevent possibility of acquiring a controling terminal
    $SIG{'HUP'} = 'IGNORE';
    if ($pid = fork) { exit 0; }

    ## Change working directory
    chdir "/";

    ## Clear file creation mask
    umask 0;

    ## Close open file descriptors
    close(STDIN);
    close(STDOUT);
    close(STDERR);

    ## Reopen stderr, stdout, stdin to /dev/null
    open(STDIN,  "+>/dev/null");
    open(STDOUT, "+>&STDIN");
    open(STDERR, "+>&STDIN");
}

