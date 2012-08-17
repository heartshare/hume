#!/usr/bin/perl 
#===============================================================================
#
#         FILE: tips.pl
#
#        USAGE: ./tips.pl  
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
#      CREATED: 08/17/2012 03:20:52 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;



foreach $file (glob "$mimedir/*");
foreach $file (map { glob $_."/*/" } split ':', $mimedir) {
    next if ($file =~ m!(^|/)(\.|\#)|(\~)$!);
}



foreach $priority ( sort { $b <=> $a} keys %priorities);


($pkg, $type) = ($ordercode =~ m{^(.*):(\S*)});


next if grep (/^\Q$entrycode\E$/, @orderlist);


my $USAGE = qq/Usage:
    snmptt [<options>]
Options:
    --daemon
    --debug=n
    --debugfile=filename
    --dump
    --help
    --ini=filename
    --version
    --time
/;


print $USAGE if $usage;




# Global config variables

my $snmptt_system_name;
my $daemon;
my $dns_enable;




my $state_time_format_sql;











