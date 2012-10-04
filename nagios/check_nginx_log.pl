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

my $logfile;
my $errordb_msg = "";
my %msg;

my $log_pos;

$logfile = "/opt/nginx/logs/error.log";



sub do_job($) {

    my $file = shift;


    my $cond_dao = 0;
    my $cond_service = 0;
    my $dbname = "";
    my $region = 0;
    my $region_cond = 0;
    my $region_service = 0;

    my $itr = 0;

    my $bw = File::ReadBackwards->new( "$file" ) or return;

    until ( $bw->eof ) {
        return if $itr >= 10000;
        $itr++;

        my $line = $bw->readline;
        chomp $line;

        return if $line =~ m/================check\ for\ push_module\ slab\ error=================/gmx;

		if ($line =~ m/ngx_slab_alloc\(\)\ failed:\ no\ memory/gmx) {
			system("/opt/nginx/sbin/nginx -s stop");
			sleep 2;
			system ("echo 'restart' >> /opt/nginx/logs/cron.log");
			system("/opt/nginx/sbin/nginx");
			return;
		}

    }

}

do_job($logfile);
system("echo '================check for push_module slab error=================' >>$logfile");
