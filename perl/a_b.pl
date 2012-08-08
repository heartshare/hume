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
my $out_file = undef;

my $options = GetOptions (
    "help|h"    => \&usage,
    "file|f=s"  => \$upstream_file,
    "outfile|o=s"   => \$out_file,
    "upstream|u=s"    => \$upstream,
);

usage() unless (defined $upstream_file && defined $upstream && defined $out_file);

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
            next unless $line =~ m/\d+/gmx;
            $line =~ s/\ //gmx;
            $line =~ s/\t//gmx;
            if ($line =~ m/^\#/gmx) {
                #print "hello\n";
                #($unused, $unused2, $server) = split (/ /, $line, 3);
                $line =~ s/\#//gmx;
                $line =~ s/[a-zA-Z]//gmx;
                #print $line, "\n";

                #if ($line =~ m/^.*(\d+\.\d+\.\d+\.\d:\d+).*$/gmx) {
                #    print $1, "\n";
                #    $server = $1 if $1;
                #}

                $server = $line if $line;
                $ups{$up_now_up}{$up_member_flag}{server} = $server;
                $ups{$up_now_up}{$up_member_flag}{backup} = 1;
                $up_member_flag++;
                $server = undef;
            }
            else {
                #($unused, $server) = split (/ /, $line, 2);
                #$line =~ s/^.*(\d+\.\d+\.\d+\.\d:\d+).*$/$1/gmx;
                #if ($line =~ m/(\d+\.\d+\.\d+\.\d:\d+)/gmx) {
                #    print $1, "\n";
                #    $server = $1 if $1;
                #}

                $line =~ s/\#//gmx;
                $line =~ s/[a-zA-Z]//gmx;

                $server = $line if $line;
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

    my $up = $ups{$upstream};
    foreach my $key (keys %$up) {

    #foreach my $key (keys $ups{$upstream}) {
        my $local_flag = $ups{$upstream}{$key}{backup};
        if($local_flag == 0) {
            $ups{$upstream}{$key}{backup} = 1;
        }
        elsif($local_flag == 1) {
            $ups{$upstream}{$key}{backup} = 0;
        }
    }
}
else {
    usage();
}

open my $out_fd, ">$out_file" or croak "open $out_file error: $!";

foreach my $up (sort keys %ups) {
    print $out_fd "upstream $up {\n";

    my $tmp_up = $ups{$up};
    foreach my $up_key (keys %$tmp_up) {

#    foreach my $up_key (keys $ups{$up}) {
        if ($ups{$up}{$up_key}{backup} == 1) {
            print $out_fd "\#\t$ups{$up}{$up_key}{server}\n" if defined $ups{$up}{$up_key}{server};
        }
        else {
            print $out_fd "\t$ups{$up}{$up_key}{server}\n" if defined $ups{$up}{$up_key}{server};
        }
    }

    print $out_fd "}\n";
    print $out_fd "\n";
}

close $out_fd;

sub usage {
    print <<"EOF";
    $0 change backend servers from A and B
--help|h            print this page
--file|f            the upstream file
--outfile|o         the out upstream file
                NOTE:the origin file will be changed
--upstream|u        the upstream which you want to change

EOF
    exit 0;
}
