package EuropeanCustomer;

#- Implement Interface ICustomer
use base qw(ICustomer);
#use InternalID;
use strict;

#----------------------------------------------------------------------
# This is the implementation of interface ICustomer.
#----------------------------------------------------------------------
sub new
    {
    my $class = shift;
    my (%args) = @_;
    my %methods;

    # Define methods as closures to ensure information hiding
    # Methods are defined like abstract methods.
    # Derived classes have to implement these methods by their closures.
    $methods{CHECK_CREDIT} = sub {
        my $this = shift;
        push @{$this->{plan}}, "checking European customer credit\n";
    };
    $methods{CHECK_INVENTORY} = sub {
        my $this = shift;
        push @{$this->{plan}}, "checking European warehouse\n";
    };
    $methods{SHIP} = sub {
        my $this = shift;
        push @{$this->{plan}}, "Shipping to European address\n";
    };


#    $methods{CHECK_CREDIT}    = sub { print "checking European customer credit\n"; };
#    $methods{CHECK_INVENTORY} = sub { print "checking European warehouse\n"; };
#    $methods{SHIP}            = sub { print "Shipping to European address\n"; };

    #-- Make a object
    my $self = bless \%methods, $class;

    return $self;
    }

#---------------------------------------------------------
# These are the interface functions accessible to caller.
#---------------------------------------------------------
sub  check_credit {
    my $this = shift;
    $this->{CHECK_CREDIT}->();
}

sub check_inventory {
    my $this = shift;
    $this->{CHECK_INVENTORY}->();
}

sub ship {
    my $this = shift;
    $this->{SHIP}->();
}

1;


