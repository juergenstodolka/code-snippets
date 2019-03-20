package AsHash;

# -------------------------------------------------------------------------
# Fast lookup by name or by date - Hash
#
# In this implementation the tricky part is finding the oldest element for
# the remove_oldest method.
# We go over all the data structures, the values of the "data" hash and
# we are looking the element with the smallest number in the date field.
# For that we use the reduce function supplied by List::Util with the 
# ternary operator inside. 
# -------------------------------------------------------------------------

use strict;
use warnings;
 
use Time::HiRes qw(time);
use List::Util qw(reduce);
 
sub new {
    my ($class) = @_;
 
    my $self = bless {}, $class;
    $self->{data} = {};
 
    return $self;
}
 
sub add {
    my ($self, $name, $payload) = @_;
 
    $self->{data}{$name} = {
       name    => $name,
       payload => $payload,
       date    => time,
    };
    return;
}
 
sub remove_oldest {
    my ($self) = @_;
 
    my $min = reduce { $a->{date} < $b->{date} ? $a : $b } values %{ $self->{data} };
    return $self->remove_by_name($min->{name});
}
 
sub remove_by_name {
    my ($self, $name) = @_;
 
    return delete $self->{data}{$name};
}
 
sub count {
    my ($self) = @_;
    return scalar keys %{ $self->{data} };
}
 
1;