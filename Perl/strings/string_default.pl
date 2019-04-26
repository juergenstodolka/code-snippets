package StringDefaultTest;

use strict;
use warnings;
use feature qw(say);
use Test::More tests => 6;

our $VERSION = 1.0;

my %header = (
   PLS_PLOTID => 'aaa',
   PLS_ORIG_NAME => 'bbb'
);

my $filename = $header{PLS_PLOTID} || $header{PLS_ORIG_NAME};
is ($filename, 'aaa', 'Select PLS_PLOTID');

$header{PLS_PLOTID} = undef;
$filename = $header{PLS_PLOTID} || $header{PLS_ORIG_NAME};
is ($filename, 'bbb', 'Select PLS_ORIG_NAME');

sub process {
  my %default = (PLS_PLOTID => 'sub_PLS_PLOTID', PLS_ORIG_NAME => 'sub_PLS_ORIG_NAME');
  my %arg =  (%default, @_);

  return \%arg;
}

my $arg_href = process();
is ($arg_href->{PLS_PLOTID}, 'sub_PLS_PLOTID', 'Select default in subroutine');
is ($arg_href->{PLS_ORIG_NAME}, 'sub_PLS_ORIG_NAME', 'Select default in subroutine');

$arg_href = process(%header);
is ($arg_href->{PLS_PLOTID}, undef, 'Select header value in subroutine');
is ($arg_href->{PLS_ORIG_NAME}, 'bbb', 'Select header value in subroutine');

1;