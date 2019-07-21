use strict;

use List::Util qw(first);
use List::MoreUtils qw(any);
use Benchmark;

my @list = ( 1..10_000 );
my $hit = 5_000;
my $hit_regex = qr/^$hit$/; # precompute regex
my %params;
$params{$_} = 1 for @list;  # precompute hash
timethese(
    100_000, {
        'any' => sub {
            die unless ( any { $hit_regex } @list );
        },
        'first' => sub {
            die unless ( first { $hit_regex } @list );
        },
        'grep' => sub {
            die unless ( grep { $hit_regex } @list );
        },
        'hash' => sub {
            die unless ( $params{$hit} );
        },
    });

1;