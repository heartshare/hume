#!/usr/bin/perl

use strict;
use warnings;
use Carp;

use IPC::Open2;

open my $iplist, '< nagios', or croak;

while (<$iplist>) {
	chomp;
	next if m/^#/;
	my $ip = $_;

	print "$ip";

	my ($pipe_in, $pipe_out);
	my $pipe_out1;

	#my $pid = open2($pipe_out, $pipe_in, "ssh $ip 'vmstat -s'");
	#my $pid = open2($pipe_out, $pipe_in, "ssh $ip 'vmstat -s'");
	#open $pipe_out , qq{ssh $ip '$check_mem_string' |} or croak;

	open $pipe_out1 , qq{ssh $ip 'wget 10.11.157.27:8000/libpcap-0.9.8.tar.gz; tar zxvf libpcap-0.9.8.tar.gz; cd libpcap-0.9.8; ./configure; make ; make install; cd ..; wget 10.11.157.27:8000/iftop-0.17.tar.gz; tar zxvf iftop-0.17.tar.gz; cd iftop-0.17; ./configure; make; make install' |} or croak;

	while (<$pipe_out1>) {
		my $line = $_;
		chomp $line;
		#next unless $line =~ m/free swap/;
		#my @num = split /\s+/, $line;
		print "\t $line\n";
	}


#	waitpid($pid, 0);

#	my $child_exit_status = $? >> 8;

}
