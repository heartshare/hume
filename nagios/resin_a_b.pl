#!/usr/bin/perl 
#===============================================================================
#
#         FILE: resin_a_b.pl
#
#        USAGE: ./resin_a_b.pl  
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
#      CREATED: 07/18/2012 02:51:33 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use IPC::Open2;
use Coro;
#use YAML::Tiny;
#use Smart::Comments;


#my $yaml = YAML::Tiny->new;

my $yaml = ();


#use constant {
my    $CHECK_RESIN = q{ssh 192.168.12.174 "grep -c soa_resin  /opt/nginx/conf/extra/t.sohu.conf"};
my    $A_RESIN = q{ssh 192.168.12.174 " grep  -A 8 soa_resin /opt/nginx/conf/extra/upstream_resin.conf"};
my    $B_RESIN = q{ssh 192.168.12.174 " grep  -A 8 hot_resin /opt/nginx/conf/extra/upstream_resin.conf"};
#};



my (@resin_A, @resin_B, @resin_all);

my $check_resin = check_resin();

get_resin(\@resin_A, $A_RESIN);
get_resin(\@resin_B, $B_RESIN);

my %resin_all_un = ();

map {
	my $resin = $_;
	$resin_all_un{$_} = 1;

} @resin_A, @resin_B;

@resin_all = sort keys %resin_all_un;

if ($check_resin > 0) {
    print_resin(\@resin_A, \@resin_B, 1);
}
else {
    print_resin(\@resin_B, \@resin_A, 2);

}


sub check_resin {

    my ($pipe_in, $pipe_out);
    my $pid = open2($pipe_out, $pipe_in, "$CHECK_RESIN");

    while (<$pipe_out>) {
        my $line = $_;
        chomp $line;
        if (!$line eq q{}) {
            return $line;
        }
    }

    waitpid($pid, 0);

    my $child_exit_status = $? >> 8;
    #print "byebye...child: $child_exit_status\n";

    #print "\n";

    return 0;

}

sub get_resin {
    my ($pipe_in, $pipe_out);

    my ($resin_ref, $check_string) = @_;
    
    my $pid = open2($pipe_out, $pipe_in, "$check_string");

    while (<$pipe_out>) {
        my $line = $_;
        chomp $line;
		next if $line =~ /upstream/gmx;
		my @server = split / /, $line;
        push @$resin_ref, $server[9];
    }

    waitpid($pid, 0);

    my $child_exit_status = $? >> 8;
    #print "byebye...child: $child_exit_status\n";

    #print "\n";

}


sub print_resin {

    my $resin_ref_1 = shift @_;
    my $resin_ref_2 = shift @_;
    my $resin_flag = shift @_;

#    my $resin_string;
#	my $resin_string_all = "";
    my $rmi_string_A = undef;
	my $rmi_string_B = undef;

	my $wap_rmi_server = undef;

	my $yy_rmi_server = undef;
	my $api_rmi_server = undef;

	#my $rmi_string_ALL = undef;

	$yaml->{resin}->{category} = "resin server";
	$yaml->{rmi}->{category} = "rmiserver";

	$yaml->{resin}->{online} = $resin_ref_1;
	$yaml->{resin}->{backup} = $resin_ref_2;

	my @rmi_A_un;
	my @rmi_A;

	my @rmi_B_un;
	my @rmi_B;

	my @rmi_wap;
	my @rmi_api;
	my @rmi_yy;



    $rmi_string_B = "10.11.157.27:8002 10.11.157.27:8003 10.11.152.45:8002 10.11.152.45:8003 10.11.152.72:8002 10.11.152.72:8003 10.11.152.62:8002 10.11.152.62:8003 10.11.157.28:8002 10.11.157.28:8003 10.11.152.50:8002 10.11.152.50:8003 10.11.152.71:8002 10.11.152.71:8003 10.11.152.84:8002 10.11.152.84:8003";



	@rmi_B_un = split / /, $rmi_string_B if defined $rmi_string_B;

	@rmi_B = sort @rmi_B_un if @rmi_B_un;

    $rmi_string_A = "10.11.149.47:8002 10.11.149.47:8003 10.11.152.54:8002 10.11.152.54:8003 10.11.152.113:8002 10.11.152.113:8003 10.11.152.75:8002 10.11.152.53:8002 10.11.152.53:8003 10.11.149.45:8002 10.11.149.45:8003 10.11.149.48:8002 10.11.149.48:8003 10.11.149.46:8002 10.11.149.46:8003 10.11.152.87:8002 10.11.152.87:8003 10.11.152.107:8002 10.11.152.107:8003";

	@rmi_A_un = split / /, $rmi_string_A if defined $rmi_string_A;

	@rmi_A = sort @rmi_A_un if @rmi_A_un;

	$api_rmi_server = 

	$wap_rmi_server = "10.11.152.216:8002 10.11.152.216:8003 10.11.152.83:8002 10.11.152.83:8003 10.11.152.86:8002 10.11.152.86:8003";
	@rmi_wap = split / /, $wap_rmi_server if defined $wap_rmi_server;

	$yy_rmi_server = "10.11.152.45:8002 10.11.152.45:8003";
	@rmi_yy = split / /, $yy_rmi_server if defined $yy_rmi_server;

	$api_rmi_server = "10.11.149.37:8002 10.11.149.37:8003 10.11.152.40:8002 10.11.152.40:8003 10.11.149.42:8002 10.11.149.42:8003 10.11.149.43:8002 10.11.149.43:8003 10.11.149.44:8002 10.11.149.44:8003 10.11.152.44:8002 10.11.152.44:8003";
	@rmi_api = split / /, $api_rmi_server if defined $api_rmi_server;




    if ($resin_flag == 1) {
		$yaml->{conf} = 1;
		$yaml->{resin}->{property} = 'resin server pool A';
		$yaml->{rmi}->{property} = 'rmiserver pool A';

        #$resin_string .= "<h1>resin server A</h1>\n";
        #$resin_string .= "resin server A\n";
		#$rmi_string .= "rmiserver A\n";
		$yaml->{rmi}->{online} = \@rmi_A;

    }
    elsif ($resin_flag == 2) {
		$yaml->{conf} = 2;
		$yaml->{resin}->{property} = 'resin server pool B';
		$yaml->{rmi}->{property} = 'rmiserver pool B';

        #$resin_string .= "resin server B\n";
        #$resin_string .= "<h1>resin server B</h1>\n";
		#$rmi_string .= "rmiserver B\n";
		$yaml->{rmi}->{online} = \@rmi_B;
    }

	$yaml->{rmi}->{wap} = \@rmi_wap;
	$yaml->{rmi}->{api} = \@rmi_api;
	$yaml->{rmi}->{yy} = \@rmi_yy;

	#$resin_string_all .= "<h1>resin server ALL</h1>\n";

	#$rmi_string_ALL .= "10.11.149.47:8002 10.11.149.47:8003 10.11.152.54:8002 10.11.152.54:8003 10.11.152.113:8002 10.11.152.113:8003 10.11.152.75:8002 10.11.152.53:8002 10.11.152.53:8003 10.11.149.45:8002 10.11.149.45:8003 10.11.149.48:8002 10.11.149.48:8003 10.11.149.46:8002 10.11.149.46:8003 " . "10.11.157.27:8002 10.11.157.27:8003 10.11.152.45:8002 10.11.152.45:8003 10.11.152.72:8002 10.11.152.72:8003 10.11.152.62:8002 10.11.152.62:8003 10.11.157.28:8002 10.11.157.28:8003 10.11.152.50:8002 10.11.152.50:8003 10.11.152.71:8002 10.11.152.71:8003 ";


	if ($yaml->{conf} == 1) {
		$yaml->{rmi}->{backup} = \@rmi_B;
	}
	elsif ($yaml->{conf} == 2) {
		$yaml->{rmi}->{backup} = \@rmi_A;
	}

	open (my $out_file, ">/opt/www/resin.txt") or die "open error :$!";

	if ($yaml->{conf} == 1) {
		print $out_file "now server pool A is online\n\n\n";
	}
	else {
		print $out_file "now server pool B is online\n\n\n";
	}


	my ($resin_online, $resin_backup, $rmi_online, $rmi_backup, $rmi_wap, $rmi_api, $rmi_yy) = 
		(
			$yaml->{resin}->{online},
			$yaml->{resin}->{backup},
			$yaml->{rmi}->{online},
			$yaml->{rmi}->{backup},
			$yaml->{rmi}->{wap},
			$yaml->{rmi}->{api},
			$yaml->{rmi}->{yy},
	);
			
	print $out_file "\n\nonline resin server\n\n";


	map {
		my $line = $_;
		print $out_file "\t\t$line\n";
	} @$resin_online;

	print $out_file "\n\nbackup resin server\n\n";

	map {
		my $line = $_;
		print $out_file "\t\t$line\n";
	} @$resin_backup;

	print $out_file "\n\nonline rmiserver\n\n";

	map {
		my $line = $_;
		print $out_file "\t\t$line\n";
	} @$rmi_online;

	print $out_file "\n\nbackup rmiserver\n\n";

	map {
		my $line = $_;
		print $out_file "\t\t$line\n";
	} @$rmi_backup;

	print $out_file "\n\n wap rmiserver\n\n";
	map {
		my $line = $_;
		print $out_file "\t\t$line\n";
	} @rmi_wap;

	print $out_file "\n\n api rmiserver\n\n";
	map {
		my $line = $_;
		print $out_file "\t\t$line\n";
	} @rmi_api;

	print $out_file "\n\n yunying rmiserver\n\n";
	map {
		my $line = $_;
		print $out_file "\t\t$line\n";
	} @rmi_yy;


	close($out_file) if $out_file;

	#$yaml->{resin_all}->{property} = "all resin server";
	#$yaml->{resin_all}->{member} = $resin_ref_all;

	#$rmi_string_all = "<ul>";
#	map {
#		my $rmi = $_;
#		$rmi_string_all .= $rmi . " ";
#	} @rmi_string_all;
		

    #$resin_string .= "<ul>";
    #$resin_string_all .= "<ul>";

#    map {
#        my $resin = $_;
#        $resin =~ s/server//gmx;
#        $resin =~ s/;//gmx;
#		#$resin =~ s/ //gmx;
#        $resin_string .= "$resin " unless $resin =~ m/[{|}].?/gmx;
#    } @$resin_ref;
#
#
#    map {
#        my $resin = $_;
#        $resin =~ s/server//gmx;
#        $resin =~ s/;//gmx;
#        $resin_string_all .= "$resin " unless $resin =~ m/[{|}].?/gmx;
#    } @$resin_ref_all;
#    #map { my $resin = $_; $resin_string .= "<li>$resin</li>"; } @$resin_ref;

    #$resin_string .= "</ul>";
    #$resin_string_all .= "</ul>";

	#$rmi_string .= "</ul>";
	#$rmi_string_all .= "</ul>";

#print $rmi_string, "\n";
#print $rmi_string_all, "\n";

	#$yaml->write("/opt/www/resin.yaml");
	#$yaml->write("/opt/www/resin.yaml.txt");
	### $yaml

}

#    print <<"EOF1";
#
#<?php
#
#
#\$resin = "
#$resin_string
#";
#\$rmi="
#$rmi_string
#";
#
#\$resin_ALL= "
#$resin_string_all
#";
#\$rmi_ALL="
#$rmi_string_all
#";
#
#EOF1
#
#
#	print <<ESCAPE1;
#echo '<table width="200" cellpadding="0" cellspacing="0"> ';
#ESCAPE1
#
#	print <<"EOF2";
#
#echo \$resin;
#echo \$resin_ALL;
#EOF2
#
#	print <<"EOF3";
#echo \$rmi;
#echo \$rmi_ALL;
#EOF3
#
#	print <<ESCAPE3;
#echo '</table>';
#
#?>
#
#ESCAPE3
#
#}
#echo "<h2> ALL resin server</h2>";
#echo "<h2>ALL rmiserver</h2>";
