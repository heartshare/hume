#!/usr/bin/perl 
#===============================================================================
#
#         FILE: a_b.pl
#
#        USAGE: ./a_b.pl  
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
#      CREATED: 08/01/2012 05:14:49 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

#use Smart::Comments;

#use File::Slurp;

#use Modern::Perl;

use Getopt::Long;

use Carp qw(croak);

my $upstream_file = undef;
my $upstream = undef;

my $options = GetOptions (
    "help|h"    => \&usage,
    "file|f=s"  => \$upstream_file,
    "upstream|u=s"    => \$upstream,
);

usage() unless (defined $upstream_file && defined $upstream);

#### $upstream_file
#### $upstream

open (my $up_fd, "<$upstream_file") or croak "open";

my %ups = ();

my $up_member_flag = 0;
my $up_now_up = undef;

my ($unused, $unused2, $server) = ();

while (<$up_fd>) {
    chomp;
    my $line = $_;


    next if $line =~ m/^\#?$/gmx;

    if ($line  =~ m/upstream/gmx) {
        $up_member_flag = 0;
        my ($unused, $up) = split (/ /, $line, 3);
        $up_now_up = $up;
        $ups{$up_now_up} = {};
        $up_member_flag = 1;
    }

    elsif ($line =~ m/\}/gmx) {
        $up_member_flag = 0;
    }

    else {

        if ($up_member_flag) {
            if ($line =~ m/^\#/gmx) {
                #print "hello\n";
                ($unused, $unused2, $server) = split (/ /, $line, 3);
                $ups{$up_now_up}{$up_member_flag}{server} = $server;
                $ups{$up_now_up}{$up_member_flag}{backup} = 1;
                $up_member_flag++;
                $server = undef;
            }
            else {
                ($unused, $server) = split (/ /, $line, 2);
                $ups{$up_now_up}{$up_member_flag}{server} = $server;
                $ups{$up_now_up}{$up_member_flag}{backup} = 0;
                $up_member_flag++;
                $server = undef;
            }

        }  
    }


}

#use Data::Dumper qw(Dumper);

#say Dumper $ups{toolbar};

if (defined $ups{$upstream}) {
    foreach my $key (keys $ups{$upstream}) {
        if($ups{$upstream}{$key}{backup} == 0) {
            $ups{$upstream}{$key}{backup} = 1;
        }
        elsif($ups{$upstream}{$key}{backup} == 1) {
            $ups{$upstream}{$key}{backup} = 0;
        }
    }
}
else {
    usage();
}

foreach my $up (sort keys %ups) {
    print "upstream $up {\n";
    foreach my $up_key (keys $ups{$up}) {
        if ($ups{$up}{$up_key}{backup} == 1) {
            print "#\t\t$ups{$up}{$up_key}{server}\n" if defined $ups{$up}{$up_key}{server};
        }
        else {
            print "\t\t$ups{$up}{$up_key}{server}\n" if defined $ups{$up}{$up_key}{server};
        }
    }

    print "}\n";
    print "\n";
}

sub usage {
    print <<"EOF";
    $0 change backend servers from A to B
--help|h            print this page
--file|f            the upstream file
                NOTE:the origin file will be changed
--upstream|u        the upstream which you want to change

EOF
    exit 0;
}
