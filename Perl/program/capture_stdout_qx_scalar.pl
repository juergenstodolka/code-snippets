package main;

use strict;
use warnings;

# Instead of the backticks that are hard to see and hard to search for, 
# we can use the qx operator of perl.
my $out = qx(perl ./external.pl);
my $status = print "==$out==\n";

1;