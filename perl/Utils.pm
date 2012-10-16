#
#===============================================================================
#
#         FILE: NyFunc.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: xiahoufeng (hume), whymaths@gmail.com
#      COMPANY: whymaths
#      VERSION: 1.0
#      CREATED: 07/25/2012 02:25:15 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
 
@EXPORT_OK = qw(currenttime write_to);

$VERSION=0.0.1;

sub currenttime {
    my @now_time = localtime(time);

    my $year = $now_time[5] + 1900;
    my $month = $now_time[4] + 1;
    my $day = $now_time[3];


    my $now_time = "$year" . "_" . "$month"."_"."$day"."_"
        ."$now_time[2]" . "_" . "$now_time[1]"."_"."$now_time[0]";

    return $now_time;
}

sub write_to{
    return;
}


1;
