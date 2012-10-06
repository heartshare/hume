#!/usr/bin/perl 
#===============================================================================
#
#         FILE: check_soa_log.pl
#
#        USAGE: ./check_soa_log.pl  
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
#      CREATED: 09/07/2012 04:34:32 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;


use File::ReadBackwards;

my %logfile;
my $errordb_msg = "";
my %msg;

my $log_pos;

$logfile{1} = "/home/sohutw/log/sohuMBSD.log";

my $pid;

open my $pidfile, "< /home/sohutw/bin/sohuMBSD.pid" or die;
while (<$pidfile>) {
	my $line = $_;
	$pid = $line;
}




map {
	my $each = $_;
   	do_job($logfile{$each}, $each);
   	system("echo '================check for error=================' >>$logfile{$_}");
} qw(1);

sub do_job($$) {

    my $file = shift;
    my $unused = shift;


    my $itr = 0;

    my $bw = File::ReadBackwards->new( "$file" ) or return;

    until ( $bw->eof ) {
        #return if $itr >= 1;

        my $line = $bw->readline;
        chomp $line;

        last if $line =~ m/================check\ for\ error=================/gmx;
        $itr++;

    }


	chomp $pid;
	print "$pid\n";

	my $cnt = kill 0, $pid;

	if ($itr == 0 ||  $cnt == 0) {
		print "hello\n";
		system("/home/sohutw/bin/sohutw.sh sohuMBSD 1");
    }

}
