use strict;
use warnings;

# Converting an array to a hash is a fairly common use for map. In this example
# the values of the hash are irrelevant; we are only checking for the existence 
# of hash keys. 

my %dictionary = map { $_, 1 } qw(cat dog man woman hat glove);

my @words = qw(dog kat wimen hat man glov);

foreach my $word (@words) {
    if (not $dictionary{$word}) {   
        print "Possible misspelled word: $word\n";
    }
}