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
use Modern::Perl;

use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);


use File::ReadBackwards;

my %logfile;
my $errordb_msg = "";

$logfile{8002} = "/opt/newtw/log/server/rmi_8002/rmi_8002_error.log";
$logfile{8003} = "/opt/newtw/log/server/rmi_8002/rmi_8002_error.log";


map {
    do_job($logfile{$_}, $_);
} qw(8002 8003);


sub do_job($$) {

    my $file = shift;
    my $port = shift;

    my $bw = File::ReadBackwards->new( "$file" ) or die "can't read $file: $!\n";
    my $latest_line;

    until ( $bw->eof ) {
        my $line = $bw->readline;
        next unless $line =~ m/Too many connections/gmx;

        if ($line =~ m/com\.sohu\.twitter\.[a-zA-Z]+\.service\.impl/gmx) {
            if ($line =~ m/com\.sohu\.twitter\.[a-zA-Z]+\.dao\.impl\.([a-zA-Z]+)DaoImpl/gmx) {
                $errordb_msg .= "$port: $1\n";
            }
        }

        $latest_line = $line;
    }

}


open my $tmp_out, "> /tmp/soa_log" or die "$!";

print $tmp_out "$errordb_msg\n";

close $tmp_out;


#
#if ($out_rate >= 80) {
#    print "network output too high: $out_rate%\n";
#    exit $ERRORS{'CRITICAL'};
#}
#
#
#print "ok, in: $in_rate%; out: $out_rate%\n";
#exit $ERRORS{'OK'};
#

#open my $nrpe_host, "< /tmp/soa_log" or die "cannot open /tmp/soa_log: $!";
