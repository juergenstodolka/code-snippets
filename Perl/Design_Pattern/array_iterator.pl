use strict;

#---------------------------------------------------------------
# Returns an functiona as Iterator to iterate over an array.
# We use a closure to store the array and the current element $i
# we want to access.
#---------------------------------------------------------------
sub array_iterator {

    my ($input_array) = @_;
    my $i = 0;    # this will index into $input_array

    return sub {
        return unless $i <= $#{$input_array};
        return $input_array->[ $i++ ];
    };
}

my @names = ( 'Mimi', 'Martha', 'Hugo', 'Esmeralda' );

my $it = array_iterator( \@names );

while ( my $value = $it->() ) {
    print qq|$value\n|;
}

1;
