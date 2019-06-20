package ArrayUtils;

use strict;
use warnings;
use Carp;

#----------------------------------------------------------------
# Constructor
#----------------------------------------------------------------
sub new {
    my $class = shift;

    return bless {}, $class;
}

#------------------------------------------------------------------------------
# Purpose  :
# Parameter: $f    - function reference
#            $aref - array reference
# Return   :
#------------------------------------------------------------------------------
sub process_array {
  my $self = shift;
  my $f    = shift;  # Assuming that $f is a function reference...
  my $aref = shift;  # Apply function $f on this array

  if (ref $aref ne 'ARRAY') {
    confess 'Wrong function syntax. Usage: process_array(function_ref, array_ref,[hash]) ';
  }

  my @ret;

  foreach my $ele (@$aref) {
      if (ref $f eq 'CODE') {
         push @ret, $f->(ele => $ele, @_);  # call it with the remaining arguments
      }
  }

  return @ret;
}

#----------------------------------------------------------------
# Destructor.
#----------------------------------------------------------------
sub DESTROY {
    my $self = shift;

}

1;