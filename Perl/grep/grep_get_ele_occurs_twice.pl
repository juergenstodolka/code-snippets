use strict;
use warnings;

# The second argument to grep is "evaluated in a list context" before the first
# list element is passed to grep's BLOCK or EXPR. 
# This means that the grep on the right completely loads the %count hash 
# before the grep on the left begins evaluating its BLOCK.
my %count;
my @crops = qw(wheat corn barley rice corn soybean hay 
            alfalfa rice hay beets corn hay);
my @dupes = grep { $count{$_} == 2 } 
              grep { ++$count{$_} > 1 } @crops;
print "@dupes\n";


