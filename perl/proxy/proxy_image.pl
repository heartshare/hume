#!/usr/bin/perl
use strict;
use warnings;

my $timeout = shift @ARGV;

$timeout = 2 unless $timeout;

use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->timeout($timeout);
#$ua->env_proxy;

open my $http_fd, "<image_test.list" or die "cannot open wap.http: $!";

my %https;

while (<$http_fd>) {
	chomp;
	my $line  = $_;
	#my ($key, $value) = split /@@/, $line;
    my $value = $line;

    if ($line =~ m/.*\/(.*)\.(.*)$/gmx) {
        $https{$value} = "$1.$2";
    }
}

close $http_fd;


for my $http (keys %https) {
    my $url = 'http://10.11.6.204/image.php?url=http://' . $http;
    #my $url = 'http://'.$http;
	my $response = $ua->get($url);

	if ($response->is_success) {
        open my $out, "> /tmp/$https{$http}" or die;
		print $out $response->decoded_content;  # or whatever
        close $out;
		#print $response->decoded_content;  # or whatever
	}
	else {
		print "$url timeout\n";
	}

}
