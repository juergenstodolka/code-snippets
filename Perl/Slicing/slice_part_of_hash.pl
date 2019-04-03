use strict;
use warnings;
use Data::Dumper;

my %object = ( 
    name  => 'Rhesa',
    fruit => 'Mango',
    dog   => 'Spot',
    cat   => 'Stofje',
);

# We want all pets stored in hash %object
my @animals = qw( dog cat );
my %pets;
@pets{ @animals } = @object{ @animals };

print Data::Dumper->Dump([\%pets],[qw(pets)]);

# Alternative solution 
sub hash_slice {
    my ($hr, @k) = @_;
    return map { $_ => $hr->{$_} } @k;
}

my %person = ( 
    firstname  => 'Lizzy',
    surname    => 'Koenig',
    age        =>  22,
    city       => 'Erlangen',
);

my @n = ('surname', 'firstname');
my %names = hash_slice(\%person, @n);
print '-' x 70 . "\n";
print Data::Dumper->Dump([\%names],[qw(NAMES)]);