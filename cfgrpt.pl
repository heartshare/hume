#!/usr/bin/perl
chop($OS = `uname -srp`);

#print "-== Hostname ==-\n";
#print `/bin/hostname`;

print "-== OS ==-\n";
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

print "-== CPU ==-\n";
if ($OS =~ /Linux/) {
	@cpuinfo = split(/\n\n/, `/bin/cat /proc/cpuinfo`);
	$cpuinfo[0] =~ s/.*model name\s:\s([^\n]*).*/$1/s;
	print "Qty:\t".int(@cpuinfo)."\nModel:\t".$cpuinfo[0]."\n";
}
if ($OS =~ /FreeBSD/) {
	$cpumodel = `/sbin/sysctl -n hw.model`;
	$cpuqty = `/sbin/sysctl -n hw.ncpu`;
	print "Qty:\t".$cpuqty."Model:\t".$cpumodel;
}
if ($OS =~ /SunOS/) {
	@cpuinfo = split(/(?=Status)/,`/usr/sbin/psrinfo -v`);
	print "Qty:\t".int(@cpuinfo)."\n";
	$cpuinfo[0] =~ /The (\w+) .*at (\w+) MHz.*/s;
	print "Model:\t".$1." ".$2." MHz\n";
}

print "-== Memory ==-\n";
if ($OS =~ /Linux/) {
	$memory = `/bin/cat /proc/meminfo`;
	$memory =~ m/.*Mem:\s*(\d*)\s*\d*\s*(\d*).*/s;
	print "Total:\t".int($1/1024/1024)." MB\n";
#  print "Total:\t".int($1/1024/1024)." MB\nFree:\t".int($2/1024/1024)." MB\n";
}
if ($OS =~ /FreeBSD/) {
	$memtotal = int(`/sbin/sysctl -n hw.physmem`/1024/1024);
	print "Total:\t".$memtotal." MB\n";
	@memfree = split(/\n/,`/usr/bin/vmstat`);
	$memfree[2] =~ s/\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)\s+.*/$1/s;
#  print "Free:\t".int($memfree[2]/1024)." MB\n";
}
if ($OS =~ /SunOS/) {
	$memtotal=`/usr/sbin/prtconf`;
	$memtotal=~ s/.*Memory size: (\d+) .*/$1/s;
	print "Total:\t".$memtotal." MB\n";
	@memfree = split(/\n/,`/bin/vmstat 1 2`);
	$memfree[3] =~ s/\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)\s+.*/$1/s;
#  print "Free:\t".int($memfree[3]/1024)." MB\n";
}

print "-== Hard Disks ==-\n";
@df = split(/\n/,`df -k`);
if ($OS =~ /Linux/) {
	@procparts = split(/\n/,`/bin/cat /proc/partitions`);
	for (@procparts) {
		($null,$major,$minor,$blocks,$name) = split(/\s+/,$_);
		if ( ($minor =~ m/\d+/) && (($minor % 16) == 0) ) { 
			print ">>> $name\nTotal:\t".int($blocks/1024)." MB\n";
			my $avail = 0;
			for (@df) {
				if (/$name/) {
					($part, $total, $used, $avai) = split(/\s+/,$_);
					$avail += $avai;
				}
			}
#      print "Avail:\t".int($avail/1024)." MB\n";
		}
	}
}
if ($OS =~ /FreeBSD/) {
	for (@df) {
		~ m/\/dev\/(\w+)\w{3}\s+.*/s;
		if (length($1)) { push(@hdlist,$1);}
	}
	%seen = ( );
	foreach $item (@hdlist) {
		push(@hds, $item) unless $seen{$item}++;
	}
	foreach $name (@hds) {
		print ">>> $name\n";
		$hdtotal = `/sbin/disklabel $name`;
		$hdtotal =~ s/.*c:\s+(\d+)\s+.*/$1/s;
		print "Total:\t".int($hdtotal/2/1024)." MB\n";
		my $avail = 0;  
		for (@df) { 
			if (/$name/) {
				($part, $total, $used, $avai) = split(/\s+/,$_); 
				$avail += $avai;
			} 
		} 
#    print "Avail:\t".int($avail/1024)." MB\n";
	}
}  
if ($OS =~ /SunOS/) {
	for (@df) {
		~ m/\/dev\/dsk\/(\w+)\w{2}\s+.*/s;
		if (length($1)) { push(@hdlist,$1);}
	}
	%seen = ( );
	foreach $item (@hdlist) {
		push(@hds, $item) unless $seen{$item}++;
	}
	foreach $name (@hds) {
		print ">>> $name\n";
		$hdtotal = `/usr/sbin/prtvtoc -h /dev/dsk/$name"s2"`;
		$hdtotal =~ s/.*\n\s+2\s+\d+\s+\d+\s+\d+\s+(\d+).*/$1/s;
		print "Total:\t".int($hdtotal/2/1024)." MB\n";
		my $avail = 0;
		for (@df) {
			if (/$name/) {
				($part, $total, $used, $avai) = split(/\s+/,$_);
				$avail += $avai;
			}
		}
#    print "Avail:\t".int($avail/1024)." MB\n";
	}
}

print "-== Network ==-\n";
if ($OS =~ /Linux/) {
	@netconf = split(/\n\n/, `/sbin/ifconfig`); 
	@pciconf = split(/\n\n/, `/sbin/lspci -v`);
	$premac = 0;
	foreach my $device (@netconf) {
		if ($device !~ /127.0.0.1/) {
			($dev, $mac, $ip, $irq) = $device =~ m/([\w:]+).*([\dA-Z:]{17}).*inet \D*([\d\.]*).*Interrupt:(\d*).*/s;
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
	@netconf = split(/\n(?=\w)/, `/sbin/ifconfig`);
	@pciconf = split(/\n(?=\w)/, `/usr/sbin/pciconf -lv`);
	for (@netconf) {
		if ((!/127.0.0.1/) && (/inet/)) {
			($dev, $mac) = /(\w+).*ether\s+([\d\:a-f]*).*/s;
			foreach my $pci (@pciconf) {
				if ($pci =~ /$dev/) { 
					$pci =~ /.*vendor\s+=\s+'([^']*)'.*device\s+=\s+'([^']*)'.*/s;
					print ">>> $dev\nType:\t$1 $2\n";
					last;
				}
			}
			print "MAC:\t".$mac."\n";
			@inets = split(/(?=inet)/, $_);
			for (@inets) {
				if (/inet\s+([\d\.]{7,15}).*/s) { print "IP:\t".$1."\n"; }
			}
		}
	}
}
if ($OS =~ /SunOS/) {
	@netconf = split(/\n(?=\w)/, `/sbin/ifconfig -a`);
	$premac = 0;
	for (@netconf) {
		if ((!/127.0.0.1/) && (/inet/)) {
			($dev, $ip, $mac) = /(\w+).*inet ([\d\.]*) .*ether ([\d\:a-f]*).*/s;
			if ($premac =~ /$mac/) { print "IP:\t$ip\n"; next; }
			$premac=$mac;
			print ">>> $dev\nIP:\t$ip\nMAC:\t$mac\n";
		}
	}
}

