#!/usr/bin/perl 
#===============================================================================
#
#         FILE: installed_modules.pl
#
#        USAGE: ./installed_modules.pl  
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
#      CREATED: 10/26/2012 04:57:49 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Modern::Perl;

use ExtUtils::Installed;

my $inst= ExtUtils::Installed->new();
my @modules = $inst->modules();

foreach(@modules)
{
my $ver = $inst->version($_) || "???";
printf("%-12s -- %s\n", $_, $ver);
}
exit 0;
