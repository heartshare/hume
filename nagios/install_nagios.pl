#!/usr/bin/perl

use strict;
use warnings;
use Carp;

use IPC::Open2;

my $prog = shift @ARGV;

print $prog, "\n";

open my $iplist, '< nagios_host', or croak;

#my $check_mem = 'command[check_mem]=/usr/local/nagios/libexec/check_mem.sh -w \$ARG1\$ -c \$ARG2\$';

while (<$iplist>) {
	chomp;
	next if m/^#/;
	my $ip = (split / /, $_)[0];

	print "$ip\n";

	my ($pipe_in, $pipe_out);
	my $pipe_out1;

	#my $pid = open2($pipe_out, $pipe_in, "ssh $ip 'vmstat -s'");
	#my $pid = open2($pipe_out, $pipe_in, "ssh $ip 'vmstat -s'");
	#open $pipe_out , qq{ssh $ip '$check_mem_string' |} or croak;

	system "scp /root/xiahou/$prog $ip:/usr/local/nagios/libexec/";
	system "ssh $ip 'chmod +x /usr/local/nagios/libexec/$prog' ";
	#system "ssh $ip 'perl /usr/local/nagios/libexec/$prog 80' ";
	#system "ssh $ip echo 'command[check_mem]=/usr/local/nagios/libexec/$prog -w \$ARG1\$ -c \$ARG2\$' >>/usr/local/nagios/etc/nrpe.cfg";

	my $args = 'command[check_float]=/usr/local/nagios/libexec/' . $prog . ' \$ARG1\$ ';
	#open $pipe_out1 , qq{ ssh $ip ' sed -i "/check_float/d" /usr/local/nagios/etc/nrpe.cfg;sed -i "/check_mem/d" /usr/local/nagios/etc/nrpe.cfg;echo $check_mem >>/usr/local/nagios/etc/nrpe.cfg;echo $args >>/usr/local/nagios/etc/nrpe.cfg;pkill nrpe;/usr/local/nagios/bin/nrpe -c /usr/local/nagios/etc/nrpe.cfg -d '|} or croak;

	open $pipe_out1 , qq{ ssh $ip ' sed -i "/check_float/d" /usr/local/nagios/etc/nrpe.cfg;echo $args >>/usr/local/nagios/etc/nrpe.cfg;pkill nrpe;/usr/local/nagios/bin/nrpe -c /usr/local/nagios/etc/nrpe.cfg -d '|} or croak;


	while (<$pipe_out1>) {
		my $line = $_;
		chomp $line;
		print "\t $line\n";
	}



#	my $child_exit_status = $? >> 8;

}
