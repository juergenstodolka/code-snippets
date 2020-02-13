use strict;

my %zugriffe=(
  'start.htm'      => 53,
  'inhalt.htm'     => 123,
  'uebungen.htm'   => 77,
  'einleitung.htm' => 12
);

print qq|Sort hash by values:\n|;
print '-' x 30 . "\n";

print join "\n", 
  map{($_->[0]). ': ' . ($_->[1])}
  sort{$a->[1] <=> $b->[1]} 
  map{[$_, $zugriffe{$_}] }
  keys %zugriffe;

1;