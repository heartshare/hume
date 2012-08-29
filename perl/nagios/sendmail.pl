#!/usr/bin/perl 
#===============================================================================
#
#         FILE: sendmail.pl
#
#        USAGE: ./sendmail.pl  
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
#      CREATED: 08/29/2012 05:35:18 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;


use Mail::Sender;

ref ($sender = new Mail::Sender({from => 'twitter@sohu.com',smtp => '192.168.95.88'})) or die "$Mail::Sender::Error\n";

@lines=<STDIN>;
my $content= join("\n", @lines);

(ref ($sender->MailMsg(
            {to => $ARGV[0], subject => $ARGV[1],
                msg => $content
            }))
        and print "Mail sent OK."
) or die "$Mail::Sender::Error\n";
