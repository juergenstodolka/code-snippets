use strict;
use warnings;
use Data::Dumper;

# Preserves @array  :)
my @array = ('hello', 3, 'world', 3, 123);

my @digitless = grep { $_ ne ''}
                map { ( my $x = $_) =~ tr/0-9//d;    
                   $x; 
                 } @array;

print Data::Dumper->Dump([\@array],[qw(*array)]);
print Data::Dumper->Dump([\@digitless],[qw(*digitless)]);