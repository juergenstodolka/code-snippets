use strict;
use warnings;
use Data::Dumper;

#--------------------------------------------------
# Initalise a hash.
#--------------------------------------------------
my @rows = ('a', 'b', 'c');
my %hash;

@hash{@rows} = (1, 2, 3);

map { print "key=$_ value=$hash{$_} \n"; } keys %hash;
print '-' x 70 . "\n";

print Data::Dumper->Dump([\%hash], [qw(HASH)]);
1;
