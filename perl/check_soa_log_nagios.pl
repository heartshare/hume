#!/usr/bin/perl 
#===============================================================================
#
#         FILE: check_float.pl
#
#        USAGE: ./check_float.pl  
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
#      CREATED: 08/31/2012 11:31:26 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Storable;

my $port = shift @ARGV;

my $st_file = "/tmp/soa.st.$port";
my $st_log = "/tmp/soa_log.$port";

#use Smart::Comments;

use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);


open my $nrpe_host, "< $st_log" or die "cannot open $st_log: $!";


while (<$nrpe_host>) {
    chomp;

    my $line = $_;

    ### $line

    if ( defined $line && $line ne "") {
#        my @infos = split / /, $line;
#
#        for my $info (@infos) {
#            if ($info =~ m/IKv/gmx) {
#                $info .= ":Service";
#            }
#            elsif ($info =~ m/IList/gmx) {
#                $info .= ":Service";
#            }
#            else {
#                $info .= ":DataBase";
#            }
#        }
#
#        $line = join " ", @infos;
        store \$line, $st_file;
        print "soa error: $line\n";
        exit $ERRORS{'CRITICAL'};
    }

}


my $lineref = retrieve($st_file) if -f $st_file;

print "ok, soa ok: $$lineref\n" if defined $$lineref;

my $line = "";

store \$line, $st_file;

exit $ERRORS{'OK'};
