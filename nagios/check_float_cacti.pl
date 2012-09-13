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


my $net_in;
my $net_out;

my $net_in_old;
my $net_out_old;


my $net_dev;

#for (1..5) {


	open $net_dev, "< /proc/net/dev" or die "cannot open /proc/net/dev: $!";

	while (<$net_dev>) {
		chomp;
		next unless /eth0/;
		my $line = $_;
        # 红帽新老版本之间/proc/net/dev 文件格式不一样
		$net_in_old =( split /\s+/, (split /:/, $line)[1])[0];
		$net_out_old =( split /\s+/, (split /:/, $line)[1])[8];
	}

	close $net_dev;

	sleep 10;

	open $net_dev, "< /proc/net/dev" or die "cannot open /proc/net/dev: $!";

	while (<$net_dev>) {
		chomp;
		next unless /eth0/;
		my $line = $_;
		$net_in =( split /\s+/, (split /:/, $line)[1])[0];
		$net_out =( split /\s+/, (split /:/, $line)[1])[8];
	}

	my $in_rate_1 = (($net_in - $net_in_old) * 800)/(1024*1024*1024*10);
	my $out_rate_1 = (($net_out - $net_out_old) * 800)/(1024*1024*1024*10);

	my $in_rate = sprintf("%.2f", $in_rate_1);
	my $out_rate = sprintf("%.2f", $out_rate_1);

	open my $tmp_out, "> /tmp/float" or die "$!";

	print $tmp_out "$in_rate\n";
	print $tmp_out "$out_rate\n";

	close $tmp_out;

#}
