use strict;
use warnings;
use Test::More 'no_plan';

BEGIN {
  use_ok('Readonly');
}

my %active = (
    'top'    => 'top frame',
    'prev'   => 'previous frame',
    'next'   => 'next frame',
    'backup' => 'backup frame',
    'last'   => 'last frame',
);

my @frames = qw(login play dummy search);

# slicing: extract values in hash and store it into array
@frames[-1, -2, -3] = @active{'top', 'prev', 'backup'};

my @expected = ('login', 'backup frame', 'previous frame', 'top frame');

is_deeply(\@expected, \@frames);


1;

