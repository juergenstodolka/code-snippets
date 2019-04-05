use strict;
use warnings;

my @a = (0 .. 9, 'a' .. 'z', '@', '$', '?', '%', '!', 'A' .. 'Z');
my $password = join '', map { $a[int rand @a] } 0 .. 10;
print "$password\n";