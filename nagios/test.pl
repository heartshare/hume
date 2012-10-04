#!/usr/bin/perl 
#===============================================================================
#
#         FILE: test.pl
#
#        USAGE: ./test.pl  
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
#      CREATED: 09/12/2012 05:48:46 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Modern::Perl;


my $str = " ste <wr >";

$str =~ s/^\s+//gmx;

say $str;
