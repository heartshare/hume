#!/usr/bin/env perl

use strict;
use warnings;

use Gearman::Client;
use Storable qw( freeze );

use POSIX qw(strftime getpid);

my $client = Gearman::Client->new;
$client->job_servers('10.11.6.204');




#my $resultref = $client->do_task("df");
#my $resultref = $client->do_task("df.192.168.12.155");

#print "$$resultref\n";

open my $ip_fd, "</opt/work/me.ip" or die "open ip file error: $!";
my $ip;
while(<$ip_fd>) {
    $ip = $_;
    chomp $ip;
}



my $tasks = $client->new_task_set;
#my $handle = $tasks->add_task(sum => freeze([ 3, 5 ]), {
#        on_complete => sub { print ${ $_[0] }, "\n" }
#    }
#);

my $handle = $tasks->add_task(dfs => df(), {
        on_complete => sub { print "df success\n"; }
    }
);


$tasks->wait;


sub df {
    my $now_string = strftime "%a %b %e %H:%M:%S %Y", localtime;

    my $ret = `df -h`;
    my $msg = "===================================================\n$now_string\n\n$ip\n\n" . $ret;
}
