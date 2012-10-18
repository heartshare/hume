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

sub get_os {
    chop(my $OS = `uname -srp`);
    print $OS;
    if ($OS =~ /Linux/) {
        open(INPUT, "</etc/redhat-release")
            or die "Couldn't open /etc/redhat-release. OS might be other Linux distribution.\n";
        $_= <INPUT>;
        ~ /Red Hat Linux (.*)release (.*) \(.*/s;
        print " (RedHat $1$2)\n";
        close(INPUT);
    } else {
        print "\n";
    }
    if ($OS =~ /Linux/) {
        my @cpuinfo = split(/\n\n/, `/bin/cat /proc/cpuinfo`);
        $cpuinfo[0] =~ s/.*model name\s:\s([^\n]*).*/$1/s;
        print "Qty:\t".int(@cpuinfo)."\nModel:\t".$cpuinfo[0]."\n";
    }

    print "-== Memory ==-\n";
    if ($OS =~ /Linux/) {
        my $memory = `/bin/cat /proc/meminfo`;
        $memory =~ m/.*Mem:\s*(\d*)\s*\d*\s*(\d*).*/s;
        print "Total:\t".int($1/1024/1024)." MB\n";
        #print "Total:\t".int($1/1024/1024)." MB\nFree:\t".int($2/1024/1024)." MB\n";
    }


    if ($OS =~ /FreeBSD/) {
        my $cpumodel = `/sbin/sysctl -n hw.model`;
        my $cpuqty = `/sbin/sysctl -n hw.ncpu`;
        print "Qty:\t".$cpuqty."Model:\t".$cpumodel;
    }

    if ($OS =~ /FreeBSD/) {
        my $memtotal = int(`/sbin/sysctl -n hw.physmem`/1024/1024);
        print "Total:\t".$memtotal." MB\n";
        my @memfree = split(/\n/,`/usr/bin/vmstat`);
        $memfree[2] =~ s/\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)\s+.*/$1/s;
        #print "Free:\t".int($memfree[2]/1024)." MB\n";
    }


    print "-== Hard Disks ==-\n";
    my @df = split(/\n/,`df -k`);
    if ($OS =~ /Linux/) {
        my @procparts = split(/\n/,`/bin/cat /proc/partitions`);
        for (@procparts) {
            my ($null,$major,$minor,$blocks,$name) = split(/\s+/,$_);
            if ( ($minor =~ m/\d+/) && (($minor % 16) == 0) ) {
                print ">>> $name\nTotal:\t".int($blocks/1024)." MB\n";
                my $avail = 0;
                for (@df) {
                    if (/$name/) {
                        my ($part, $total, $used, $avai) = split(/\s+/,$_);
                        $avail += $avai;
                    }
                }
                print "Avail:\t".int($avail/1024)." MB\n";
            }
        }
    }
    if ($OS =~ /FreeBSD/) {
        my @hdlist;
        for (@df) {
            ~ m/\/dev\/(\w+)\w{3}\s+.*/s;
            if (length($1)) {
                push(@hdlist,$1);
            }
        }
        my %seen = ( );
        my @hds;
        foreach my $item (@hdlist) {
            push(@hds, $item) unless $seen{$item}++;
        }
        foreach my $name (@hds) {
            print ">>> $name\n";
            my $hdtotal = `/sbin/disklabel $name`;
            $hdtotal =~ s/.*c:\s+(\d+)\s+.*/$1/s;
            print "Total:\t".int($hdtotal/2/1024)." MB\n";
            my $avail = 0;
            for (@df) {
                if (/$name/) {
                    my ($part, $total, $used, $avai) = split(/\s+/,$_);
                    $avail += $avai;
                }
            }
            print "Avail:\t".int($avail/1024)." MB\n";
        }
    }


    print "-== Network ==-\n";
    if ($OS =~ /Linux/) {
        my @netconf = split(/\n\n/, `/sbin/ifconfig`);
        my @pciconf = split(/\n\n/, `/sbin/lspci -v`);
        my $premac = 0;
        foreach my $device (@netconf) {
            if ($device !~ /127.0.0.1/) {
                my ($dev, $mac, $ip, $irq) = $device =~ m/([\w:]+).*([\dA-Z:]{17}).*inet \D*([\d\.]*).*Interrupt:(\d*).*/s;
                if ($premac =~ /$mac/) { print "IP:\t$ip\n"; next; }
                $premac=$mac;
                foreach my $pci (@pciconf) {
                    if ($pci =~ /IRQ\s$irq/) {
                        $pci =~ /.*Ethernet controller: ([^\n]*).*/s;
                        print ">>> $dev\nType:\t$1\nMAC:\t$mac\nIP:\t$ip\n";
                        last;
                    }
                }
            }

        }
    }
    if ($OS =~ /FreeBSD/) {
        my @netconf = split(/\n(?=\w)/, `/sbin/ifconfig`);
        my @pciconf = split(/\n(?=\w)/, `/usr/sbin/pciconf -lv`);
        for (@netconf) {
            if ((!/127.0.0.1/) && (/inet/)) {
                my ($dev, $mac) = /(\w+).*ether\s+([\d\:a-f]*).*/s;
                foreach my $pci (@pciconf) {
                    if ($pci =~ /$dev/) {
                        $pci =~ /.*vendor\s+=\s+'([^']*)'.*device\s+=\s+'([^']*)'.*/s;
                        print ">>> $dev\nType:\t$1 $2\n";
                        last;
                    }
                }
                print "MAC:\t".$mac."\n";
                my @inets = split(/(?=inet)/, $_);
                for (@inets) {
                    if (/inet\s+([\d\.]{7,15}).*/s) { print "IP:\t".$1."\n"; }
                }
            }
        }
    }



}

1;
