#!/usr/bin/perl 
#===============================================================================
#
#         FILE: comm.pl
#
#        USAGE: ./comm.pl  
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
#      CREATED: 08/02/2012 11:52:09 AM
#     REVISION: ---
#===============================================================================

1;

sub run_command {
    my ($logfile, $cmd) = @_;

    write_log($logfile, $cmd);

    open (my $pipe, "$cmd 2>&1 1>/dev/null |");

    my $err;

    while (<$pipe>) {
        $err .= $_;
    }

    close ($pipe);

    die $er) if $err;
}


sub time_now {
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);

    $year += 1900;

    $mon += 1;

    my $time = $year . "-" . add0($mon) . add0($mday) . add0($hour) . add0($min) . add0(sec);

    return $time;
}


sub write_log {
    my ($logfile, $message) = @_;

    my $time = time_now();

    open (my $fh, '>>', $logfile) or die "cannot open file $logfile: $!";

    print $fh "$time : $message\n" if defined $fh;

    print "$time: $message" if defined $fh;

    close $fh if defined $fh;
}

sub write_log_array {
    my ($logfile, @messages) = @_;
    chomp @messages;

    my $time = time_now();

    open (my $fh, ">>", $logfile) or die "cannot open file $logfile: $!";

    print $fh "$time: \n" if defined $fh;

    print "$time : \n";

    map { print $fh "$_\n" if defined $fh; print "$_\n"; } @messages;
 
    close $fh if defined $fh;
}

sub add0 {
    my $num = shift;

    if ($num < 10) {
        return "0" . $num;
    else {
        return $num;
    }
}


# usage: die usage();

sub usage {
    return <<'_EOC_';
Usage:
    xxx [options]

Options:


Examples:

_EOC_
}


sub quote_str($) {
    my $s = shift;
    $s =~ s/\\/\\\\/g;
    $s =~ s/"/\\"/g;
    $s =~ s/\n/\\n/g;
    $s =~ s/\t/\\t/g;
    $s =~ s/\r/\\r/g;

    return qq{"$s"};
}
