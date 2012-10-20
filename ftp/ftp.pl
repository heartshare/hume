#!/usr/bin/perl

# a module making life easier

use Net::FTP;


$ftp = Net::FTP->new('target_site.somewhere.xxx');
$ftp->login('username','password');

$ftp->binary();


$ftp->cwd('/some/path/to/somewhere/');

foreach $name ('file1', 'file2', 'file3') {
	$ftp->get($name,$name);
}


$ftp->quit;
