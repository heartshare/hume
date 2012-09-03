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

#use Smart::Comments;


use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);



my $check_percent = shift @ARGV;

die "usage: $0 percent\n" unless $check_percent;



my $net_in;
my $net_out;

my $net_in_old;
my $net_out_old;


open my $nrpe_host, "< /tmp/float" or die "cannot open /tmp/float: $!";


#my $net_dev;
#
#
#open $net_dev, "< /proc/net/dev" or die "cannot open /pro/net/dev: $!";
#
#while (<$net_dev>) {
#    chomp;
#    next unless /eth0/;
#    my $line = $_;
#    $net_in_old =( split /\s+/, (split /:/, $line)[1])[0];
#    $net_out_old =( split /\s+/, (split /:/, $line)[1])[8];
#}
#
#close $net_dev;
#
#sleep 1;
#
#
#
#open $net_dev, "< /proc/net/dev" or die "cannot open /pro/net/dev: $!";
#
#while (<$net_dev>) {
#    chomp;
#    next unless /eth0/;
#    my $line = $_;
#    $net_in =( split /\s+/, (split /:/, $line)[1])[0];
#    $net_out =( split /\s+/, (split /:/, $line)[1])[8];
#}
#
#my $in_rate_1 = (($net_in - $net_in_old) * 800)/(1024*1024*1024);
#my $out_rate_1 = (($net_out - $net_out_old) * 800)/(1024*1024*1024);

my $in_rate_1 = 0;
my $out_rate_1 = 0;
my $itr = 0;

while (<$nrpe_host>) {
	chomp;

	my $line = $_;

	### $line

	$in_rate_1 = $line if $itr == 0;
	$out_rate_1 = $line if $itr == 1;

	$itr++;
}

my $in_rate = sprintf("%0.2f", $in_rate_1);
my $out_rate = sprintf("%0.2f", $out_rate_1);

if ($in_rate >= 80) {
    print "network input too high: $in_rate%\n";
    exit $ERRORS{'CRITICAL'};
}

if ($out_rate >= 80) {
    print "network output too high: $out_rate%\n";
    exit $ERRORS{'CRITICAL'};
}


print "ok, in: $in_rate%; out: $out_rate%\n";
exit $ERRORS{'OK'};
