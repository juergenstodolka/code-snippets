use strict;
use warnings;

# An array of references to anonymous arrays
my @data_points = ( [ 5, 12 ], [ 20, -3 ], 
                 [ 2, 2 ], [ 13, 20 ] );

my @y_gt_x = grep { $_->[1] > $_->[0] } @data_points;

foreach my $xy (@y_gt_x) {
   print "$xy->[0], $xy->[1]\n";
}