#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  git.pl
#
#        USAGE:  ./git.pl  
#
#  DESCRIPTION:  git status
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Anders Lee (), jianghumanbu@gmail.com
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  06/25/2011 10:12:43 AM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


my $info = `git st`;

my ($branch) = $info =~ /^#\s+On branch (\S+)/;

say $branch;
