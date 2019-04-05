use strict;
use warnings;

# Instead of searching an array, we can use map to convert
# the array to a hash and then do a direct lookup by hash key. 
# The code using map is simpler and, if we are doing repeated searches, 
# more efficient.

# In this example we use map and a hash to find the array index for a particular value:

my @teams = qw (
    Miami Oregon Florida Tennessee Texas 
    Oklahoma Nebraska LSU Colorado Maryland
);

my %rank = map { $teams[$_], $_ + 1 } 0 .. $#teams;
print "Colorado: $rank{Colorado}\n"; 
print "Texas: $rank{Texas} (hook 'em, Horns!)\n"; 