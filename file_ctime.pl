#!/usr/bin/perl 
#===============================================================================
#
#         FILE: file_time.pl
#
#        USAGE: ./file_time.pl  
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
#      CREATED: 10/12/2012 03:14:08 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Modern::Perl;

use Time::Duration;

for my $file (@ARGV) {
    my $age = $^T - (stat($file))[9];  # 9 = modtime
    print "$file was modified ", ago($age);
    print "\n";
}
