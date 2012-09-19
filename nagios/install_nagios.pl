#!/usr/bin/perl

use strict;
use warnings;
use Carp;

use IPC::Open2;

my $prog = shift @ARGV;
my $iplist = shift @ARGV;

open my $list, "< test.txt", or croak;

print $prog, "\n";


#my $check_mem = 'command[check_mem]=/usr/local/nagios/libexec/check_mem.sh -w \$ARG1\$ -c \$ARG2\$';

while (<$list>) {
	chomp;
	next if m/^$/;
	next if m/^#/;
	my $ip = $_;
	#my $ip = (split /:/, $_)[0];
	#my $port = (split /:/, $_)[1];

	print "$ip\n";

	my ($pipe_in, $pipe_out);
	my $pipe_out1;

	#my $pid = open2($pipe_out, $pipe_in, "ssh $ip 'vmstat -s'");
	#my $pid = open2($pipe_out, $pipe_in, "ssh $ip 'vmstat -s'");
	#open $pipe_out , qq{ssh $ip '$check_mem_string' |} or croak;

	system "scp /opt/work/$prog $ip:/usr/local/nagios/libexec/";
	system "ssh $ip 'chmod +x /usr/local/nagios/libexec/$prog' ";

    #system "scp $1 root@$ip:/opt/check_float_cacti.pl";
    #system "ssh $ip 'chmod +x /opt/check_float_cacti.pl';
    #system qq{ssh $ip sed -i '/float_cacti/d' /var/spool/cron/root};

	#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print ls;' | ssh $ip crontab;

	#ssh $ip crontab -l |  perl -e 'while (<STDIN>){ print $_;} print "*/1 * * * * perl /opt/check_\n";' | ssh $ip crontab;



	#system "ssh $ip 'perl /usr/local/nagios/libexec/$prog 80' ";
	#system "ssh $ip echo 'command[check_mem]=/usr/local/nagios/libexec/$prog -w \$ARG1\$ -c \$ARG2\$' >>/usr/local/nagios/etc/nrpe.cfg";

	#my $args = 'command[check_soa_log]=/usr/local/nagios/libexec/' . $prog . ' \$ARG1\$';
	#my $check_mem = 'command[check_mem]=/usr/local/nagios/libexec/check_mem.sh -w \$ARG1\$ -c \$ARG2\$';

	#open $pipe_out1 , qq{ ssh $ip ' sed -i "/check_soa/d" /usr/local/nagios/etc/nrpe.cfg;echo $args >>/usr/local/nagios/etc/nrpe.cfg;pkill nrpe;/usr/local/nagios/bin/nrpe -c /usr/local/nagios/etc/nrpe.cfg -d '|} or croak;

	open $pipe_out1 , qq{ ssh $ip 'pkill nrpe;/usr/local/nagios/bin/nrpe -c /usr/local/nagios/etc/nrpe.cfg -d '|} or croak;

	while (<$pipe_out1>) {
		my $line = $_;
		chomp $line;
		print "\t $line\n";
	}



#	my $child_exit_status = $? >> 8;

}
