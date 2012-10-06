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

my $search = shift @ARGV;

my $st_file = "/tmp/soa";
my $st_error_file = "/tmp/soa.error";

#use Smart::Comments;

use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);


my $soa_ref = retrieve($st_file) if -f $st_file;

my $line = $soa_ref->{$search};


### split error servers

if (defined $line && $line ne "") {
    my $soa_error_ref = retrieve($st_error_file) if -f $st_error_file;
    $soa_error_ref->{$search} = $line;
    store $soa_error_ref, $st_error_file;
    print "soa server disconn with CC: $line\n";
    exit $ERRORS{'CRITICAL'};
}

my $soa_error_ref = retrieve($st_error_file) if -f $st_error_file;
my $error_line = $soa_error_ref->{$search};

$error_line = "" unless defined $error_line;

print "soa server conn with CC: $error_line\n";
delete $soa_error_ref->{$search};
store $soa_error_ref, $st_error_file;

exit $ERRORS{'OK'};
