#!/usr/bin/perl

# a module making life easier

use Net::FTP;

# for debugging: $ftp = Net::FTP->new('site','Debug',10);
# open a connection and log in!

$ftp = Net::FTP->new('target_site.somewhere.xxx');
$ftp->login('username','password');

# set transfer mode to binary

$ftp->binary();

# change the directory on the ftp site

$ftp->cwd('/some/path/to/somewhere/');

foreach $name ('file1', 'file2', 'file3') {

# get's arguments are in the following order:
# ftp server's filename
# filename to save the transfer to on the local machine
# can be simply used as get($name) if you want the same name

	$ftp->get($name,$name);
}

# ftp done!

$ftp->quit;

