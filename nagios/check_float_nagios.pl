#!/usr/bin/perl 
#===============================================================================
#
#         FILE: check_float.pl
#
#        USAGE: ./check_float.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR:  (), |whymaths@gmail.com|
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 08/31/2012 11:31:26 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Modern::Perl;

use Smart::Comments;


my $net_in;
my $net_out;

my $net_in_old;
my $net_out_old;


my $net_dev;


open $net_dev, "< /proc/net/dev" or die "cannot open /pro/net/dev: $!";

while (<$net_dev>) {
    chomp;
    next unless /eth2/;
    my $line = $_;
    $net_in_old =( split /\s+/, (split /:/, $line)[1])[0];
    $net_out_old =( split /\s+/, (split /:/, $line)[1])[8];
    #print "$net_in_old \n";
    #print "$net_out_old \n";
}

close $net_dev;

sleep 1;



open $net_dev, "< /proc/net/dev" or die "cannot open /pro/net/dev: $!";

while (<$net_dev>) {
    chomp;
    next unless /eth2/;
    my $line = $_;
    $net_in =( split /\s+/, (split /:/, $line)[1])[0];
    $net_out =( split /\s+/, (split /:/, $line)[1])[8];
    #print "$net_in\n";
    #print "$net_out\n";
}


print $net_in - $net_in_old, "\n";
print $net_out - $net_out_old, "\n";
