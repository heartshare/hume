#!/usr/bin/perl 
#===============================================================================
#
#         FILE: gitcheck.pl
#
#        USAGE: ./gitcheck.pl  
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
#      CREATED: 06/08/2012 05:40:48 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;


use Modern::Perl;
use File::Basename;

my $nb_errors = 0;
for my $filepath (`git diff --cached --name-only`) {
    chomp $filepath;
    open my $fh, "<" . $filepath;

    my @file_infos = fileparse( $filepath, qr/\.[^.]*/ );
    given ( $file_infos[2] ) {
        when ( /^.pl$/ ) {
            system ( qq{/usr/bin/perl -wc $filepath} ) == 0 or say "\n" and $nb_errors++;
        }
        when ( /^.tmpl$/ ) {
            #TODO
        }
        when ( /^.js$/ ) {
            #TODO
        }
    }
}

my $filepath;
for my $l ( split '\n', `git diff-index -p -M --cached HEAD` ) {
    if ( $l =~ /^diff --git a\/([^ ]*) .*$/ ) {
        $filepath = $1;
    }
    given ( $l ) {
        # if there is a file called *.log, stop
        when ( /\.log/ ) {
            say "$filepath contains console.log ($l)";
            $nb_errors++;
        }
        # if there is a warn Data::Dumper::Dumper introduced, stop
        when ( /^[^(\#|\-)]+warn Data::Dumper::Dumper/ ) {
            say "$filepath contains warn Data::Dumper::Dumper ($l)";
            $nb_errors++;
        }
        # check if there is a warn, that could be unconditionnal, but just warn, don't stop
        when ( /^[^(\#|\-)]+warn/ ) {
            # stay silent if we're in a template, a "warn" here is fair, it's usually a message or a css class
            unless ($filepath =~ /\.tt$/) {
            say "$filepath contains warn ($l)";
            }
        }
        # check if there is a ` introduced, that is a mysqlism in databases. Can be valid so don't stop, just warn
        when (/^\+.*`.*/) {
            say "$filepath contains a ` ($l)";
        }
        # check if there is a merge conflict marker and just warn (we probably could stop if there is one)
        when ( m/^<<<<<</ or m/^>>>>>>/ or m/^======/ ) {
            say "$filepath contains $& ($l)";
        }
    }
}

if ( $nb_errors ) {
    say "\nAre you sure you want to commit ?";
    say "You can commit with the --no-verify argument";
    exit 1;
}
exit 0;
