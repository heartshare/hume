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

#use Smart::Comments;

use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);


open my $nrpe_host, "< /tmp/soa_log" or die "cannot open /tmp/soa_log: $!";


while (<$nrpe_host>) {
    chomp;

    my $line = $_;

    ### $line

    if ( defined $line && $line ne "") {
        print "database connection error: $line\n";
        exit $ERRORS{'CRITICAL'};
    }

}

print "ok, soa database connection ok\n";
exit $ERRORS{'OK'};
