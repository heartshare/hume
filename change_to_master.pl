#!/usr/bin/perl 
#===============================================================================
#
#         FILE: change_to_master.pl
#
#        USAGE: ./change_to_master.pl  
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
#      CREATED: 07/25/2012 02:04:05 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Getopt::Long;
use File::Spec;

use lib "MyFunc.pm";

use Smart::Comments;

my $g_script_name = $0;

my ($g_volume, $g_workdir, $g_workfile) = File::Spec->splitpath($g_script_name);

### $g_volume
### $g_script_name
### $g_workdir 
### $g_workfile


require "$g_workdir/sub_functions.pl";

my $g_logfile;

my $g_haconf = "/etc/keepalived/haconf";

my $g_vrrpins;

my $g_retry = 6;


GetOptions(
    "logfile=s" => \$g_logfile,
    "vrrp-instances=s" => \$g_vrrpins
);


my $options_needed_string;

(defined $g_logfile) or $options_needed_string .= "--logfile is needed!\n";
(defined $g_vrrpins) or $options_needed_string .= "--vrrp-instances is needed\n";

if ($options_needed_string) {
    die $options_needed_string . "\n please see help --help";
}
