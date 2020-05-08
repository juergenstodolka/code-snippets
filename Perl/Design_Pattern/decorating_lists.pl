use strict;
use warnings;

# Many built-in functions are list filters. 
# They take a list, do something to it and return a resultant list.
# This is similar to Unix filters, which expect lines of data on standard input, which # they manipulate in some way, before sending the result to standard output.
opendir my $DIR, '.',
    or die "Can't read this directory, how did you get here?\n";

my @files =
      reverse
      sort
      map { -d $_ ? $_ : () } readdir $DIR;

closedir $DIR;

print "Subdirectories found:\n";
map { print " * $_\n" } @files;

1;