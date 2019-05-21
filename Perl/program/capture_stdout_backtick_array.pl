use strict;
use warnings;
 
# Instead of assigning to a scalar variable we can also assign the backtick to an array, 
# putting it in LIST context. 

my @out = qx{perl ./external.pl};
print ("==$out[0]==\n");
 
print ("==$out[1]==\n");

1;