#!/usr/bin/env perl

use strict;
use warnings;

use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);

use Getopt::Long;
use Cache::Memcached;

#use Smart::Comments;
#use Test::Simple tests => 1;

use List::MoreUtils qw(any);

my @ignore_queues = (

    '10.11.152.39:22133:timeline_prepare_pull',
    '10.11.152.76:22133:external_info',

);


# special needs
my %special_queues = (

    '10.11.152.39:22133:timeline_msg_insert' => 200,
    '10.11.152.39:22133:timeline_msg_del' => 200,
    '10.11.152.39:22133:timeline_follow_insert' => 500,
    '10.11.152.39:22133:timeline_follow_del' => 200,


);

my (
    $servers,
    $more,
    %servers,
    $usage,
);


GetOptions (
    's|servers=s'   => \$servers,
    'm|more'    => \$more,
    'h|help'    => \$usage,
);

my $usage_msg =  <<"EOF";
$0 -s 10.11.123.23:22133:1000,10.11.23.23:22122:10000

s|servers server lists
h|help  print this help

EOF

print $usage_msg if $usage;
exit(3) if $usage;


my @temp1 = split(/,/, $servers);

for my $temp1 (@temp1) {
    my @temp2 = split(/:/, $temp1);

    if ($#temp2) {
        my $host = shift @temp2;
        my $port = shift @temp2;
        my $threshold = shift @temp2;

        $servers{"$host:$port"}{'threshold'} = $threshold;
    }

}

### $servers
### @temp1
### %servers

my $memd = new Cache::Memcached;

my @tmp_servers =  keys %servers;

$memd->set_servers(\@tmp_servers);

# $memd

my $tmp_stats = $memd->stats();
my %stats = %$tmp_stats;


my $alive_servers_ref =  $stats{hosts};

my $alive_servers = keys %$alive_servers_ref;
my @alive_servers = keys %$alive_servers_ref;

### @alive_servers


#map {
#    sleep 1;
#    ok ( $alive_servers ne 0, "ok" );
#} 1..1000;


print "timeout\n" unless $alive_servers;
exit $ERRORS{'CRITICAL'} unless $alive_servers;

my $blocked_servers;

for my $server (@alive_servers) {
    my $st = $alive_servers_ref->{$server};

    my $total = $stats{total};

    # $total

    my $misc = $st->{misc};

    my $block_msg = "";
    for my $item (keys %$misc) {
        if ($item =~ m/^queue_(.*)_mem_items$/gmx) {
            my $item_msg = $1;
            my $item_value = $misc->{$item};
            print "$item_msg($item_value)\n" if $more;
            next if any { /$server\:$item_msg/ } @ignore_queues;
            my $server_item = "$server:$item_msg";
            if (exists $special_queues{$server_item}) {
                if ($item_value >= $special_queues{$server_item}) {
                    $block_msg .= "$item_msg($item_value) ";
                }
            }
            elsif ($item_value >= $servers{"$server"}{'threshold'}) {
                $block_msg .= "$item_msg($item_value) ";
            }
        }
    }
    print "$block_msg\n" unless $block_msg eq "";
    $blocked_servers++ unless $block_msg eq "";

}

exit $ERRORS{'CRITICAL'} if $blocked_servers;

print "kestrel ok!\n" unless $blocked_servers;
exit $ERRORS{'OK'} unless $blocked_servers;
