use strict;
use Test::More 'no_plan';

#----------------------------------------------------------------------
# Purpose: Work with regular expressions
#----------------------------------------------------------------------

sub is_valid_rail_track_number {
  my ($track) = @_;

  return $track =~ /[1-9]/xms;
}

sub is_valid_rail_track_number_plus_char {
  my ($track) = @_;

  return $track =~ /[1-9][ab]/xms;
}

#-----------------------------------------------------------------------
# Here start the tests
#----------------------------------------------------------------------- 
subtest 'Regular Expression with one an more elements' => sub {
  plan tests => 4;

  ok(is_valid_rail_track_number(3), 'is single number');
  isnt(is_valid_rail_track_number(0), 1,'is not a single number');

  is(is_valid_rail_track_number('4b'), 1,'is a single number with char');
  isnt(is_valid_rail_track_number('4bb'), 0,'is a single number with char');
};

1;
