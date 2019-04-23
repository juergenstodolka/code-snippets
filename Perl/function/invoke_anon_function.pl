use strict;
use warnings;
use Carp;

sub invoke_anon_function {
  my $func = shift;
  confess ('You have to pass a a CODE reference!') if (ref($func) ne 'CODE');
  return $func->(@_);
}

sub named_func {
  print "I am a named function!\n";
}

eval {
  invoke_anon_function( \&named_func );
  invoke_anon_function( sub {print "Who am I?\n"} );
  invoke_anon_function( named_func() );
};

if ($@) {
  print qq|Exeption caught: $@ \n|;
}