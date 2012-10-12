#!/usr/bin/perl
use strict;
use warnings;

use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);

my $timeout = shift @ARGV;

$timeout = 2 unless $timeout;


open my $http_out, "</opt/work/wap.out" or die "cannot open wap.out: $!";

my $res;
my $str;

while (<$http_out>) {
	chomp;
	my $line  = $_;
	($res, $str) = split /@@/, $line;
}

print "$str\n";

exit $ERRORS{'OK'} if $res =~ m/ok/;
exit $ERRORS{'CRITICAL'};
