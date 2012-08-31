#!/usr/bin/perl

use strict;
use warnings;
use Carp;

#use Smart::Comments;

use Coro;

my $lock = new Coro::Semaphore;
my $locked_intr;

use IPC::Open2;

#open my $iplist, '< iplist.bak', or croak;
open my $iplist, '< iplist', or croak;

my @ips;

while (<$iplist>) {
	chomp;
	next if m/^#/;
	next if m/10\.11\.152\.217/;
	my $ip = $_;


	push @ips, $ip;

#	waitpid($pid, 0);

#	my $child_exit_status = $? >> 8;

}


$locked_intr = 0;


my @coros;

foreach my $ip (@ips) {

	async {
		#$lock->down;
		do_work_wget($ip);
		#$lock->up;

		#do_work_install($ip);#, cb => Coro::rouse_cb;
		#@res = Coro::rouse_wait;
	};
};

foreach my $ip (@ips) {

	async {
		do_work_install($ip);
	};
};

#push @coros, async { Event::loop() };

#$_->join for @coros;

cede;



sub do_work_wget {

	my $ip = shift;
	my $pipe_out1;

	open $pipe_out1, qq{ssh $ip ' rm -rf libpcap-*; rm -rf iftop-*;wget 10.11.157.27:8000/libpcap-0.9.8.tar.gz;wget 10.11.157.27:8000/iftop-0.17.tar.gz' |} or croak;

	while (<$pipe_out1>) {
	}
	print "$ip ....wget ok!\n";
}

sub do_work_install {

	my $ip = shift;

	my $pipe_out2;
	open $pipe_out2 , qq{ssh $ip 'rm -rf libpcap-0.9.8; tar zxvf libpcap-0.9.8.tar.gz; cd libpcap-0.9.8; ./configure; make ; make install; cd ..; rm -rf iftop-0.17; tar zxvf iftop-0.17.tar.gz; cd iftop-0.17; ./configure; make; make install' |} or croak;

	while (<$pipe_out2>) {
		my $line = $_;
	}
	print " $ip ....install ok\n";

}
