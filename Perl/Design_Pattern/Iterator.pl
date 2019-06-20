use strict;
use warnings;

use feature qw(say);

my $print_closure = sub { say "$_[0]"; };

my @names = ('Juergen', 'Tini', 'Lizzy', 'Sarah');
map { $print_closure->($_)} @names;

