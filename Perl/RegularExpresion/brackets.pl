use strict;
use Test::More 'no_plan';

#----------------------------------------------------------------------
# Purpose: Work with regular expressions
#----------------------------------------------------------------------

sub match_optional_second_name {
  my ($track) = @_;

  # String in brackets is optional
  return $track =~ /Marius (Müller )?Osterhase/;
}

sub select_any_name {
  my ($track) = @_;

  return $track =~ /Das Wetter ist (toll|richtig schlecht)/;
}

sub multiple_words_in_string {
  my ($track) = @_;

  return $track =~ /Ba(na){2,5}ne/;
}


#-----------------------------------------------------------------------
# Here start the tests
#----------------------------------------------------------------------- 
subtest 'Regular Expression using brackets' => sub {
  plan tests => 2;

  is( match_optional_second_name('Marius Osterhase'), 1,'optional without second name');
  is( match_optional_second_name('Marius Müller Osterhase'), 1,'optional with second name');  
};

subtest 'Regular Expression using brackets with alternative strings' => sub {
  plan tests => 3;

  is( select_any_name('Das Wetter ist toll'), 1, q|select 'toll'|);
  is( select_any_name('Das Wetter ist richtig schlecht'), 1, q|select 'richtig schlecht'|);
  isnt( select_any_name('Das Wetter ist richtig blöd'), 1, q|cannot select the correct string|);
};


subtest 'Regular Expression using brackets/multiple occurence' => sub {
  plan tests => 3;

  is(multiple_words_in_string('Bananane'), 1,'multiple sub strings');
  is(multiple_words_in_string('Banananane'), 1,'multiple sub strings');  
  isnt(multiple_words_in_string('Banane'), 1,'no multiple sub strings');  
};

1;
