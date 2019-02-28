use strict;
use warnings;
use Carp;
use v5.10;
use Data::Dumper;

#---------------------------------------------------------------
# Purpose: Save or append data to a file.
#---------------------------------------------------------------
my $save_file = sub {
  my ($arg, $callback) = @_;

  if (ref($arg) ne 'HASH') {
    croak 'First parameter must be a hash reference!';
  }
  if (ref($callback) ne 'CODE') {
    croak 'Second parameter must be a function reference';
  }
  $arg->{mode} ||= '>';
 
  if (open (my $fh, $arg->{mode}, $arg->{file})) {
      $callback->($fh, $arg->{data});
      close $fh;
      return 1;
  }
  
  croak qq|Cannot open file [@{[$arg->{file}]}] \n|;
};

#---------------------------------------------------------------
# Purpose: read file content
# Parameters: $arg  - hash reference with (file, mode)
#             $callback - an annonymous function that is calle
#                         to read the file data. A filehandle is
#                         passed to this anon function. Return
#                         valid data as reference.
# Return: the function returns an anon function, that you can 
#         call and pass a callback function. 
#---------------------------------------------------------------
my $read_file = sub {
  my ($arg, $callback) = @_;

  if (ref($arg) ne 'HASH') {
    croak 'First parameter must be a hash reference!';
  }
  if (ref($callback) ne 'CODE') {
    croak 'Second parameter must be a function reference';
  }

  if (open my $fh, '<', $arg->{file}) {
      my $data = $callback->($fh);
      close $fh;
      return sub {
        my ($callback) = @_;
        return $callback->(undef, $data);
      };
  }

  return sub {
    my ($callback) = @_;

    my $err = qq|Cannot read file [@{[$arg->{file}]}]|;
    return $callback->($err, undef);
  };
};

#---------------------------------------------------------------
# Here starts our app.
# The read_file anon function returns a function. Pass a annon
# function to evaluate the result of read_file.
# if $err is set the file reading failed, else if $data exists,
# you can access to the lines read from file.
#---------------------------------------------------------------
my $eval_ret =
eval {
  my $file = 'not_available';
  
  $save_file->({file => $file, mode => '>>', data => "Hello Jürgen\n" }, 
    sub {
      my ($fh, $data) = @_;
      return print $fh $data;
    }
  );

  #$file = 'unknown.txt';
  $read_file->({file => $file}, sub {
    my ($fh) = @_;
    my @lines = <$fh>;
    chomp @lines;
    return \@lines;
  })->(sub {
    my ($err, $content) = @_;
    if ($err) {
      return say $err;
    }
    elsif ($content) {
      return print Data::Dumper->Dump([$content],[qw(*content)]);
    }
  });
};

say "EVAL returns: $eval_ret";

if ($@) {
  my $err = $@;
  say qq|FILE_ERROR: $err|;
}

1;
