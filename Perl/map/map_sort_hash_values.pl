use strict;

my %zugriffe=(
  'start.htm'      => 53,
  'inhalt.htm'     => 123,
  'uebungen.htm'   => 77,
  'einleitung.htm' => 12
);

print qq|Sort hash by values:\n|;
print '-' x 30 . "\n";

# Read the following lines from back to top
print join "\n", 
  map{($_->[0]) . ': ' . ($_->[1])}  # convert each element in sorted array into strings look like 'Seite: counter' 
  sort{$a->[1] <=> $b->[1]}          # sort annon array by values
  map{[$_, $zugriffe{$_}] }          # create anon array with elements [key, value]
  keys %zugriffe;

1;