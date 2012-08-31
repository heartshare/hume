#!/usr/bin/perl

use strict;
use warnings;
use Carp;

use IPC::Open2;

my $check_mem = 'command[check_mem]=/usr/local/nagios/libexec/check_mem.sh -w \$ARG1\$ -c \$ARG2\$';

my $start_nrpe = '/usr/local/nagios/bin/nrpe -c /usr/local/nagios/etc/nrpe.cfg -d';

open my $iplist, '< nagios_host', or croak;

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

	open $pipe_out1 , qq{ssh $ip 'chmod +x /usr/local/nagios/libexec/check_mem.sh; echo $check_mem >>/usr/local/nagios/etc/nrpe.cfg; pkill nrpe; $start_nrpe' |} or croak;

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
