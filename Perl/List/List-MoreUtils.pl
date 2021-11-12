use strict;

use List::MoreUtils qw(any all none notall true false firstidx first_index
   lastidx last_index insert_after insert_after_string
   apply after after_incl before before_incl indexes
   firstval first_value lastval last_value each_array
   each_arrayref pairwise natatime mesh zip uniq minmax);

use Data::Dumper;

#----------------------------------------------------------------------
sub test_all {
  print "\nAll values are non-negative: "
  if all { $_ >= 0 } (2, 4, 1);
}

#----------------------------------------------------------------------
sub test_any {
  # Returns a true value if any item in LIST meets the criterion given through BLOCK. 
  print "\nAt least one non-negative value: "
  if any { $_ >= 0 } (-5, -22, 4);

  print "\nNo-negative value: \n"
  if any { $_ <= 0 } (5, 22, 4);
}

#----------------------------------------------------------------------
sub test_none {
  # Returns a true value if no item in LIST meets the criterion given through BLOCK.
  print "\nNo non-negative values: \n"
  if none { $_ >= 0 } (-2, -12, -33);
}

#----------------------------------------------------------------------
sub test_each_array {

    my @a = (1, 3, 6, 12, 6);
    my @b = (1, 2, 4, 22, 8);
    my @c = (7, 37, 6, 12, 6);

    #  Creates an array iterator to return the elements of the list of arrays
    #  ARRAY1, ARRAY2 throughout ARRAYn in turn. That is, the first time it is
    #  called, it returns the first element of each array. The next time, it
    #  returns the second elements. And so on, until all elements are
    #  exhausted.
    #
    #  This is useful for looping over more than one array at once:
    print '-' x 20 . '-> each_array()' . "\n";

    my $ea = each_array(@a, @b, @c);

    while (my ($a, $b, $c) = $ea->() ) {

      print "$a, $b, $c \n";
    }
}

#----------------------------------------------------------------------
sub test_pairwise {

    my @a = (1 .. 5);
    my @b = (11 .. 15);

    print '-' x 20 . '-> pairwise()' . "\n";
    my @x = pairwise { $a + $b } @a , @b;
    
    print Dumper(\@x);

    my @char = qw/a b c/;
    my @number = qw/1 2 3/;
    my @p = pairwise { ($a, $b) } @a , @b;
    print Dumper(\@p);

    my %h = pairwise { ($a, $b) } @a , @b;
    print Dumper(\%h);

}



test_all();
test_any();
test_none();
test_each_array();
test_pairwise();

exit 0;