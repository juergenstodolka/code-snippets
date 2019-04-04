use strict;
use warnings;

# This example is not a practical way to implement a database, but does 
# illustrate that the only limit to the complexity of grep's block is 
# the amount of virtual memory available to the program.

# @database is array of references to anonymous hashes 
my @database = ( 
    { name      => "Wild Ginger", 
      city      => "Seattle",
      cuisine   => "Asian Thai Chinese Japanese",
      expense   => 4, 
      music     => "\0", 
      meals     => "lunch dinner",
      view      => "\0", 
      smoking   => "\0", 
      parking   => "validated",
      rating    => 4, 
      payment   => "MC VISA AMEX", 
    },
    { name      => "Wilder Mann", 
      city      => "Forchheim",
      cuisine   => "Fränkisch",
      expense   => 2, 
      music     => "\0", 
      meals     => "lunch dinner",
      view      => "\0", 
      smoking   => "\0", 
      parking   => "validated",
      rating    => 5, 
      payment   => "Cash", 
    },
    { name      => "Goldene Gans", 
      city      => "Forchheim",
      cuisine   => "Fränkisch",
      expense   => 5, 
      music     => "\0", 
      meals     => "lunch dinner",
      view      => "\0", 
      smoking   => "\0", 
      parking   => "validated",
      rating    => 5, 
      payment   => "Cash VISA", 
    },


#    { ... },  etc.
);

#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
sub findRestaurants {
    my ($database, $query) = @_;
    return grep {
        $query->{city} ? 
            lc($query->{city}) eq lc($_->{city}) : 1 
        and $query->{cuisine} ? 
            $_->{cuisine} =~ /$query->{cuisine}/i : 1 
        and $query->{min_expense} ? 
           $_->{expense} >= $query->{min_expense} : 1 
        and $query->{max_expense} ? 
           $_->{expense} <= $query->{max_expense} : 1 
        and $query->{music} ? $_->{music} : 1 
        and $query->{music_type} ? 
           $_->{music} =~ /$query->{music_type}/i : 1 
        and $query->{meals} ? 
           $_->{meals} =~ /$query->{meals}/i : 1 
        and $query->{view} ? $_->{view} : 1 
        and $query->{smoking} ? $_->{smoking} : 1 
        and $query->{parking} ? $_->{parking} : 1 
        and $query->{min_rating} ? 
           $_->{rating} >= $query->{min_rating} : 1 
        and $query->{max_rating} ? 
           $_->{rating} <= $query->{max_rating} : 1 
        and $query->{payment} ? 
           $_->{payment} =~ /$query->{payment}/i : 1
    } @$database;
}

#-- Now search your favourite restaurant
my %query = ( city => 'Seattle', cuisine => 'Asian|Thai' );
my @restaurants = findRestaurants(\@database, \%query);
print "Restaurant $restaurants[0]->{name}\n";

%query = ( cuisine => 'Fränkisch' );
@restaurants = findRestaurants(\@database, \%query);
map {
    print "Fränkisches Restaurant '$_->{name}' gefunden in $_->{city}\n";
} @restaurants;