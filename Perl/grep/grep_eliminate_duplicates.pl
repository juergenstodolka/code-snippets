use strict;
use warnings;

my @array = qw(To be or not to be that is the question);
print "@array\n";
my %counts;

my @found_words = grep { $_ =~ /b|o/i and ++$counts{$_} < 2; } @array;

print qq|Eliminate duplicate words containing character 'o' or 'i'.\n|;
print "@found_words\n";