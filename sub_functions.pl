=head1 NAME

  sub_functions.pl - Public functions for most scripts

=head1 SYNOPSIS

  sub_functions.pl should be included by other scirpts with 'require' and can not be executed wiht OS command.

=cut

#Must return 1 for 'require' in other scripts.
1;

#run os command and get STDERR message
sub runOSCmd {
  my ( $logfile, $cmd ) = @_;
  writelog ( $logfile, $cmd );

  open( my $pipe, "$cmd 2>&1 1>/dev/null |" );
  my $err;
  while( <$pipe> ) {
    $err .= $_;
  }
  close( $pipe );
  die( $err ) if ( $err );
}

sub currenttime {
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
  $year += 1900;
  $mon += 1;
  my $time = $year."-".add0($mon)."-".add0($mday)." ".add0($hour).":".add0($min).":".add0($sec);
  return $time;
}

sub writelog {
  my ( $logfile, $message ) = @_;
  my $time = currenttime();
  open(my $fh,'>>', $logfile) or die ("Cannot open file $logfile: $!");
  print $fh "$time : $message\n" if ( defined ($fh) );
  print "$time : $message\n" if ( defined ($fh) );
  close($fh) if ( defined ($fh) );
}

sub writelogs_array {
  my ( $logfile, @msgs ) = @_;
  chomp( @msgs );
  my $time = currenttime();
  open(my $fh,'>>', $logfile) or die ("Cannot open file $logfile: $!");
  print $fh "$time : \n" if ( defined ($fh) );
  print "$time : \n";
  for( my $i=0; $i<=$#msgs; $i++ ) {
    print $fh "$msgs[$i]\n" if ( defined ($fh) );
    print "$msgs[$i]\n";
  }
  close($fh) if ( defined ($fh) );
}

sub add0 {
  my $num = shift @_;
  if ( $num < 10 ) {
    return "0".$num;
  }
  else {
    return $num;
  }
}

