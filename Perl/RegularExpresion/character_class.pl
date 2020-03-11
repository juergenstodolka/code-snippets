use strict;
use Test::More 'no_plan';

#----------------------------------------------------------------------
# Purpose: Work with regular expressions
#----------------------------------------------------------------------

sub is_valid_phone_number {
  my ($track) = @_;

  # A character class defines a group of allowed characters.
  # plus sign + means one or multiple occurence
  return $track =~ /[0-9\/. -]+/xms;
}

sub is_valid_name {
  my ($track) = @_;

  # A character class defines a group of allowed characters.
  # plus sign + means one or multiple occurence
  # ^ negates the character class 
  # The second name may not contain the characters 'q' and 'z'.
  return $track =~ /Marius [^qzQZ]+ Osterhase/xms;
}

#-----------------------------------------------------------------------
# Here start the tests
#----------------------------------------------------------------------- 
subtest 'Regular Expression using character class' => sub {
  plan tests => 4;

  is(is_valid_phone_number('0651/55541-36'), 1,'is a valid phone number');
  is(is_valid_phone_number('0049 160 555678'), 1,'is a valid phone number');
  is(is_valid_phone_number('0180.23.555.63'), 1,'is a valid phone number');

  isnt(is_valid_phone_number('01555/234_556'), 0,'is not a phone number');
};

subtest 'Regular Expression using negated character class' => sub {
  plan tests => 2;

  is(is_valid_name('Marius Martin Osterhase'), 1,'is a valid second name');
  isnt(is_valid_phone_number('Marius Quentin Osterhase'), 0,'second name is wrong');
};


1;
