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
# if there are a lot of indices use a separate hash 
# Example:
Readonly my %CORRESPONDING => (
   # Key of %active   Index of @frames
     'top'          =>  -1,
     'prev'         =>  -2,
     'backup'       =>  -3
);

@frames[ values %CORRESPONDING ] = @active{ keys %CORRESPONDING };

my @expected = ('login', 'backup frame', 'previous frame', 'top frame');

is_deeply(\@expected, \@frames);


1;

