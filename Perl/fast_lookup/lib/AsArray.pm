    package AsArray;
    # -------------------------------------------------------------------------
    # Fast lookup by name or by date - Array
    #
    # The tricky part here is the implementation of remove_by_name.
    # We go over the indexes of the array from 0 to the highest index which is
    # the number of elements minus 1.
    # Then we use the first function of List::Util which is similar to grep, 
    # but stops after it founds the first matching value.
    #
    # We then use splice to remove the element from the array. 
    # -------------------------------------------------------------------------
    use strict;
    use warnings;
     
    use Time::HiRes qw(time);
    use List::Util qw(first);
     
    sub new {
        my ($class) = @_;
     
        my $self = bless {}, $class;
        $self->{data} = [];
     
        return $self;
    }
     
    sub add {
        my ($self, $name, $payload) = @_;
     
        push @{ $self->{data} }, {
           name    => $name,
           payload => $payload,
           date    => time,
        };
        return;
    }
     
    sub remove_oldest {
        my ($self) = @_;
        return shift @{ $self->{data} }
    }
     
    sub remove_by_name {
        my ($self, $name) = @_;
        
        my $index = first { $name eq $self->{data}[$_]{name} } 0 .. @{ $self->{data} } - 1;
        my ($elem) = splice @{ $self->{data} }, $index, 1; 
        return $elem;
    }
     
    sub count {
        my ($self) = @_;
        return scalar @{ $self->{data} };
    }
     
     
    1;