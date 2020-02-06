use strict;

my @objecttype  = ('Seal_FOLIE', 'FOLIE');
my $search      = 'FOL';
my $starts_with = qr/^$search/;

foreach my $item (@objecttype) {
  print "ITEM=$item starts with $search\n"  if $item =~ /$starts_with/;  
}