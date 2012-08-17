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
