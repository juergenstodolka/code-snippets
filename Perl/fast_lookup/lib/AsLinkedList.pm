package AsLinkedList;

# -------------------------------------------------------------------------
# Fast lookup by name or by date - Linked List realized with a hash
#
# In this implementation there is a lot more bookkeeping both when we add a
# new element and when we remove one. The class itself holds the name of the
# first and last elements in the "_first" and "_last" fields respectively.
# Each element in the "data" hash also has a field with the name of the 
# previous and next elements in the "_prev" and "_next" fields respectively.
#
# When we add a new element and when we remove an old element we need to update
# these fields to keep all the data structure up to date.
#
# As an improvement we might want to keep a reference to the objects instead
# of the name of the field, though I am not sure it is really an improvement. 
# -------------------------------------------------------------------------

use strict;
use warnings;
 
use Time::HiRes qw(time);
use List::Util qw(reduce);
 
sub new {
    my ($class) = @_;
 
    my $self = bless {}, $class;
    $self->{data} = {};
    $self->{_first} = undef;
    $self->{_last} = undef;
 
    return $self;
}
 
sub add {
    my ($self, $name, $payload) = @_;
 
    $self->{data}{$name} = {
       name    => $name,
       payload => $payload,
       date    => time,
       _next   => undef,
       _prev   => $self->{_last},
    };
    my $last  = $self->{_last};
    if ($last) {
        $self->{data}{$last}{_next} = $name;
    }
    if (not $self->{_first}) {
        $self->{_first} = $name;
    }
 
    $self->{_last} = $name;
 
    return;
}
 
sub remove_oldest {
    my ($self) = @_;
 
    my $first = $self->{_first};
    return if not $first;
 
    return $self->remove_by_name($first);
}
 
sub remove_by_name {
    my ($self, $name) = @_;
 
    my $element = delete $self->{data}{$name};
    my $next = $element->{_next};
    my $prev = $element->{_prev};
    $self->{data}{$next}{_prev} = $prev if $next;
    $self->{data}{$prev}{_next} = $next if $prev;
 
    if ($self->{_first} eq $name) {
        $self->{_first} = $next;
    }
    if ($self->{_last} eq $name) {
        $self->{_last} = $prev;
    }
 
    delete $element->{_next};
    delete $element->{_prev};
    return $element;
}
 
sub count {
    my ($self) = @_;
    return scalar keys %{ $self->{data} };
}
 
 
1;