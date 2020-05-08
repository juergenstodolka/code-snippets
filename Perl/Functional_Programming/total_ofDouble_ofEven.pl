use strict;
use warnings;

use Data::Dumper;
use List::Util qw( reduce any all none notall first);


my $process = sub {
	return sub {
	  "Hello\n";
	};
};
#print $process->()->();

#------------------------------------------------------------------------
# Purpose: Functional style
#          First  - get all numbers modulo 2
#          Second - multiply each of these numbers by 2
#          Third  - add each number of second result
# Return:  a anon function
#------------------------------------------------------------------------
sub compute {
    my (@num) = @_;
	return sub {
	    return reduce { $a + $b }
		       map { $_ * 2 }
	           grep { ($_ % 2) == 0} @num;
	};
};

my @numbers = (1, 5, 2, 6, 8, 3, 4, 9, 7, 6);

print Data::Dumper->Dump([\@numbers], [qw(*numbers)]);

# Result has to be the number 52 in our example.
# In this case the array is stored in the closure (currying)
my $result =  compute(@numbers)->();

print qq|Result=$result\n|;

# Alternatively
my $mod2_doubled_sum = compute(@numbers);
my $result2 = $mod2_doubled_sum->();

print qq|Result=$result2\n|;

1;