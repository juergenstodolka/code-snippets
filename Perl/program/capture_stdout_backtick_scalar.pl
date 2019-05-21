use strict;
use warnings;

# The STDERR will be printed directly to the screen untouched by the backticks. 
# If the STDOUT has multiple lines (as in our case), they will still form a 
# single multi-line string in the capturing code: 

my $out = `perl ./external.pl`;
print ("==$out==\n");