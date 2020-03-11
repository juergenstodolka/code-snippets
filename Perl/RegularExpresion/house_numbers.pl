use strict;
use Test::More 'no_plan';

#----------------------------------------------------------------------
# Purpose: Work with regular expressions
#----------------------------------------------------------------------

#-----------------------------------------------------------------------------
#   Das Fragezeichen hinter einem Element (und [1-9] ist ein Element!) besagt:
#    -  Das vorhergehende Element kann vorkommen, muss aber nicht.
#   Der letzte Code heißt also: Eine Ziffer (1-9), optional zwei weitere Ziffern (0-9), optional ein Buchstabe.
#-----------------------------------------------------------------------------
sub is_valid_house_number {
  my ($track) = @_;

  return $track =~ /[1-9][0-9]?[0-9]?[a-z]?/xms;
}

#-----------------------------------------------------------------------------
#   Das Fragezeichen hinter einem Element (und [1-9] ist ein Element!) besagt:
#    -  Das vorhergehende Element kann vorkommen, muss aber nicht.
#   In geschweiften Klammern kann ein Bereich angegewben werden, wie oft der Ausdruck
#   davor wiederholt werden soll.
#   Der letzte Code heißt also: Eine Ziffer (1-9), optional 0 bis zweimal (0-9), optional ein Buchstabe.
#-----------------------------------------------------------------------------
sub is_valid_house_number_using_curly_brackets {
  my ($track) = @_;

  return $track =~ /[1-9][0-9]{0,2}[a-z]?/xms;
}

#-----------------------------------------------------------------------
# Here start the tests
#----------------------------------------------------------------------- 
subtest 'Regular Expression with optional elements' => sub {
  plan tests => 9;

  is(is_valid_house_number('1'), 1,'is a valid house number');
  is(is_valid_house_number('20'), 1,'is a valid house number');
  is(is_valid_house_number('999'), 1,'is a valid house number');
  is(is_valid_house_number('1a'), 1,'is a valid house number');
  is(is_valid_house_number('23f'), 1,'is a valid house number');
  is(is_valid_house_number('777u'), 1,'is a valid house number');

  isnt(is_valid_house_number('1000'), 0,'is an invalid house number');
  isnt(is_valid_house_number('0'), 0,'is an invalid house number');
  isnt(is_valid_house_number('654Z'), 0,'is an invalid house number');

};

subtest 'Regular Expression with repeated elements' => sub {
  plan tests => 9;

  is(is_valid_house_number_using_curly_brackets('1'), 1,'is a valid house number');
  is(is_valid_house_number_using_curly_brackets('20'), 1,'is a valid house number');
  is(is_valid_house_number_using_curly_brackets('999'), 1,'is a valid house number');
  is(is_valid_house_number_using_curly_brackets('1a'), 1,'is a valid house number');
  is(is_valid_house_number_using_curly_brackets('23f'), 1,'is a valid house number');
  is(is_valid_house_number_using_curly_brackets('777u'), 1,'is a valid house number');

  isnt(is_valid_house_number_using_curly_brackets('1000'), 0,'is an invalid house number');
  isnt(is_valid_house_number_using_curly_brackets('0'), 0,'is an invalid house number');
  isnt(is_valid_house_number_using_curly_brackets('654Z'), 0,'is an invalid house number');

};


1;
