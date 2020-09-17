package A::Calc;

use strict;
use warnings;

use Exporter qw(import);

our $VERSION = '0.01';

# Every function (and variable) listed in the @EXPORT array is imported automatically .
# Functions foo() and bar() are imported, nothing else. Any function from the @EXPORT and  # @EXPORT_OK arrays can be requested to be imported. There is also an %EXPORT_TAGS that can
# be used to define groups of functions to be imported.
our @EXPORT = qw(add multiply);

my $base = 10;

sub add {
    validate_parameters(@_);

    my $total = 0;
    $total += $_ for (@_);
    return $total;
}

sub multiply {
}

sub validate_parameters {
    die 'Not all of them are numbers'
      if grep { /\D/ } @_;
    return 1;
}

=head1 NAME

App - application

=head1 SYNOPSIS

 A quick example for the really inpatient.

=head1 DESCRIPTION

=head2 Methods

=over 4

=item add

  Adding multiple numbers.

  add(2,3);   => 5
  add(1,2,3); => 6

  If one argument is not a number, an exeption will be thrown.

=item multiply

  NOT YET IMPLEMENTED!!!

=back

=head1 BUGS

Probably plenty but nothing I know of. Please report them to the author.

=head1 Development

Instructions to those who wish to participate in the development efforts.
E.g. where is the version control system, where is the development mailing
list or forum (if you have one).

=head1 Thanks

Potential thanks to people who helped you.

=head1 AUTHOR

Gabor Szabo <gabor@szabgab.com>

=head1 COPYRIGHT

Copyright 2006 by Gabor Szabo <gabor@szabgab.com>.

This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut

1;
