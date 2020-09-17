use strict;
use warnings;
use v5.10;

sub add {

    validate_parameters(@_);

    my $total = 0;
    $total += $_ for (@_);

    return $total;
}

sub validate_parameters {
    die 'Not all of them are numbers' if grep { /\D/ } @_;
    return 1;
}

eval {
    say add( 0,  3 );
    say add( 27, 4 );
    say add( 4,  'hallo' );
};

if ($@) {
    say "Exception: $@";
}

1;
