#!/usr/bin/perl 
#===============================================================================
#
#         FILE: lwp.pl
#
#        USAGE: ./lwp.pl  
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
#      CREATED: 08/26/2012 01:02:06 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use LWP;

use POSIX qw(strftime);

#use Smart::Comments;
use Storable;

use JSON::XS;

use IPC::Open2;

my @work_hours = 9..18;

my %search_files = (
        "platform-msg-api_online" =>  "/opt/yangxh/serverList/api_online.list",
        "platform-msg-client_online" => "/opt/yangxh/serverList/client_online.list",
        "platform-msg-third_online" => "/opt/yangxh/serverList/third_online.list",
        "platform-msg-tw_hot" => "/opt/yangxh/serverList/tw_hot.list",
        "platform-msg-tw_online" => "/opt/yangxh/serverList/tw_online.list",
        "platform-msg-tw_online2" => "/opt/yangxh/serverList/tw_online2.list",
        "platform-msg-wap_online" => "/opt/yangxh/serverList/wap_online.list",
        );

my %quite_list;
my %now_list;
my %cmp_msg;

my %quite_ip;

get_quite_list();
get_now_list();
cmp_list(\%quite_list, \%now_list);


use Carp qw{croak};


sub get_now_list {

    for my $search (keys %search_files) {
    
        my $hash_ref = {};
    
        my $browser = LWP::UserAgent->new();
        my $response= $browser->post("http://admin.ginkgo.sohu.com/application/servers/pageQuery", [ "serchString" => "$search", "limit" => 100]); 
    
    
        my $servers_hashref = decode_json $response->content;
    
    
        foreach (@{$servers_hashref->{result}}) {
            #print $_->{name}, "\n" if $_->{alive} == 1;
            my $server = $_->{name};
            $hash_ref->{$server} = 1 if $_->{alive} == 1;
    
        }
        $now_list{$search} = $hash_ref;
    }
}

sub cmp_list {

    my $list_full = shift;
    my $list = shift;


    for my $list_key (keys %$list_full) {
        my $list_full_ref = $list_full->{$list_key};
        for my $server (keys %$list_full_ref) {
            $cmp_msg{$list_key} .= "$server " unless defined $list->{$list_key}->{$server};
        }

    };
    store \%cmp_msg,  "/tmp/soa";

	### %cmp_msg
    for my $line (values %cmp_msg) {
		### $line
		my @servers;
		if ($line =~ m/ /gmx) {
	    	@servers = split / /, $line;
		}
		else {
			push @servers, $line;
		}
		open my $soa_restart, '>> /tmp/soa.restart' or die "error open /tmp/soa.restart :$!";
   		for my $server (@servers) {
			my $now_string = strftime "%a %b %e %H:%M:%S %Y", localtime;
			my $now_time = strftime "%H", localtime;
			my $in_work = in($now_time);
			### $now_time
			### $in_work
			next if ( $server =~ m/10.11.152.83:8002/gmx && $in_work );
			print $soa_restart "now restarting $server at $now_string\n";

			my ($ip, $port) = split /:/, $server;
			### $ip
			### $port
			my $pipe_out;

    		open $pipe_out , qq{ ssh newtw\@$ip '. .bash_profile ;cd /opt/newtw/apps/server/instances/rmi_$port/; ./server.sh restart '|} or croak;


    		while (<$pipe_out>) {
        		my $line_out = $_;
        		chomp $line_out;
        		print $soa_restart "\t $line_out\n";
    		}



		}
		close $soa_restart;
	}

    return;

}

sub get_quite_list {

    for my $search (keys %search_files) {

        my $hash_ref = {};

        open my $tmp, "< $search_files{$search}" or die "open $search_files{$search} error: $!\n";
        while (<$tmp>) {
            chomp;

            $hash_ref->{$_} = 1 if (defined $_ && $_ ne "");
        }
        close $tmp;

        $quite_list{$search} = $hash_ref;

    }

    return;
}





# %quite_list;


### @work_hours


sub in {

	my $now = shift;
	for my $hour(@work_hours) {
		if ($hour == $now) {
			return 1;
		}
	}
	return 0;
}
