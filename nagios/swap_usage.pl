#!/usr/bin/perl

use strict;
use warnings;
use Carp;

use IPC::Open2;


open my $iplist, '< /opt/work/iplist.bak', or croak;
open my $out, '> /opt/www/swap.txt', or croak;

while (<$iplist>) {
	chomp;
	next if m/^#/;
	my $ip = $_;

	my ($pipe_in, $pipe_out);

	#my $pid = open2($pipe_out, $pipe_in, "ssh $ip 'vmstat -s'");
	open $pipe_out , "ssh $ip 'vmstat -s' |" or croak;

	while (<$pipe_out>) {
		my $line = $_;
		chomp $line;
		next unless $line =~ m/free swap/;
		my @num = split /\s+/, $line;
		print $out $ip, "    ", $num[1], "\n" if $num[1] < 1000000;
	}


#	waitpid($pid, 0);

#	my $child_exit_status = $? >> 8;

}

close $out;
close $iplist;
