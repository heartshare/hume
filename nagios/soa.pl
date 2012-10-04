#!/usr/bin/perl

use strict;
use warnings;

map { `perl ginkgo.pl $_ >>soa.1` } qw(platform-msg-tw_online platform-msg-wap_online platform-msg-client_online platform-msg-api_online platform-msg-tw_hot);

#cat soa.1 | awk -F":" "{print $1}" | sort | uniq >>soa
