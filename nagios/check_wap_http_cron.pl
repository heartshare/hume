#!/usr/bin/perl
use strict;
use warnings;

use lib "/usr/local/nagios/libexec" ;
use utils qw (%ERRORS &print_revision &support);

my $timeout = shift @ARGV;

$timeout = 2 unless $timeout;


use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->timeout($timeout);
$ua->env_proxy;

open my $http_fd, "</opt/work/wap.http" or die "cannot open wap.http: $!";
open my $http_out, ">/opt/work/wap.out" or die "cannot open wap.out: $!";

my %https;

while (<$http_fd>) {
	chomp;
	my $line  = $_;
	my ($key, $value) = split /@@/, $line;
	$https{$key} = $value;
}

close $http_fd;

my $error_count = 0;
my $error_string = "";

for my $http (keys %https) {
	my $response = $ua->get($https{$http});

	if ($response->is_success) {
		$error_string .= "$http ok; ";
		#print $response->decoded_content;  # or whatever
	}
	else {
		$error_count++;
		$error_string .= "$http error; ";
	}

}
print $http_out "ok@@" unless $error_count;
print $http_out "error@@" if $error_count;
print $http_out substr $error_string, 0, -2;
print $http_out "\n";

close $http_out;
