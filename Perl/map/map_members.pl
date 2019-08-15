use strict;
use Data::Dumper;
use List::Util qw(reduce);

my @meetups = (
    {name => 'JavaScript', isActive => 1, members => 700 },
    {name => 'Angular'   , isActive => 1, members => 900 },
    {name => 'Node'      , isActive => 0, members => 600 },
    {name => 'React'     , isActive => 1, members => 500 },
);

#print Data::Dumper->Dump([\@meetups],[qw(meetups)]);

my $sumChain =
   reduce { $a + $b}
   map { $_->{members} - ($_->{members} * 0.1)}
   grep {  $_->{isActive} == 1 ? $_ : () }
   @meetups;


print qq|Sum of members of all active meetups, where 10% members might duplicated: $sumChain|;
