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

my $error_msg = "";
my %msg;

my $log_pos;

my $logfile = "";


for my $port (qw(8002 8003)) {

    $logfile = "/opt/newtw/log/server/rmi_$port/rmi_$port" . "_error.log";

    do_job($logfile, $port);
    system("echo '================check for database connection error=================' >>$logfile");

    #sleep 10;
    open my $tmp_out, "> /tmp/soa_log.$port" or die "$!";

    map {
        #$errordb_msg .= "$_ ";
        $error_msg = $_;
        print $tmp_out "$error_msg\n" if $msg{$error_msg} == $port;
    } sort keys %msg;

    #print $tmp_out "$errordb_msg";
    #print "$errordb_msg\n";

    close $tmp_out;

}

sub do_job {

    my $file = shift;
    my $port = shift;


    my $cond_dao = 0;
    my $cond_service = 0;
    my $dbname = "";
    my $servicename = "";
    my $region = 0;
    my $region_cond = 0;
    my $region_service = 0;

    my $itr = 0;

    my $bw = File::ReadBackwards->new( "$file" ) or return;

    until ( $bw->eof ) {
        return if $itr >= 100000;
        $itr++;

        my $line = $bw->readline;
        chomp $line;

        return if $line =~ m/================check\ for\ database\ connection\ error=================/gmx;

        next if ($line =~ m/at\ com\.sohu\.twitter\.common\.dao/gmx);

        #if ($line =~ m/com\.sohu\.twitter\.[a-zA-Z]+\.service\.impl/gmx) {
        if ($line =~ m/at\ com\.sohu\.twitter\.\S+\.service\.impl\.([a-zA-Z]+)ServiceImpl\.\S+\(([a-zA-Z]+)\.java\:([0-9]+)\)/gmx) {
            $cond_service = 1;
            $region_service = $region;
            $cond_dao = 0;
            $dbname = "";
            $servicename = "$2 line $3";

        }


        #if ($line =~ m/com\.sohu\.twitter\.[a-zA-Z]+\.dao\.impl\.([a-zA-Z]+)DaoImpl/gmx) {
        if ($cond_service && $line =~ m/at\ com\.sohu\.twitter\.\S+\.dao(?:\.impl)?\.([a-zA-Z]+)DaoImpl\.\S+\(([a-zA-Z]+)\.java\:([0-9]+)\)/gmx) {
            $cond_dao = 1;
            $region_cond = $region;
            $cond_service = 2;
            $dbname = "$2 line $3";
        }


        if ($line =~ m/Too\ many\ connections/gmx || $line =~ m/java\.sql\.SQLException:\ Couldn\'t\ get\ connection\ because\ we\ are\ at\ maximum\ connection\ count/gmx ) {
            if ($region_cond == $region_service && $cond_dao == 1 && $cond_service == 2 && $dbname ne "") {
                #print "$itr: $line\n";
                $msg{"$dbname/$servicename "} = $port;
            }

            #print "$cond_toomany\n";
        }
        unless ($line =~ m/^\s+/gmx) {
            $region++;
            $cond_dao = 0;
            $cond_service = 0;
            $dbname = "";
            $servicename = "";
        }

    }

}
