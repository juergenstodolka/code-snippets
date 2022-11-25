package ICustomer;

use strict;
use warnings;

#----------------------------------------------------------------------
# This is a abstract base class for common PLOSSYS output
#----------------------------------------------------------------------
sub new
    {
    my $class = shift;
    my (%args) = @_;
    my %methods;

    # Define methods as closures to ensure information hiding
    # Methods are defined like abstract methods.
    # Derived classes have to implement these methods by their closures.
    $methods{CHECK_CREDIT}    = sub { die "You have to implement method 'check_credit'\n"; };
    $methods{CHECK_INVENTORY} = sub { die "You have to implement method 'check_inventory'\n"; };
    $methods{SHIP}            = sub { die "You have to implement method 'ship'\n"; };

    # Data

    $methods{plan} = [];
    #-- Make a object
    my $self = bless \%methods, $class;

    return $self;
    }

#---------------------------------------------------------
# These are the interface functions accessible to caller.
#---------------------------------------------------------
sub  check_credit {
    my $this = shift;
    $this->{CHECK_CREDIT}->($this);
}

sub check_inventory {
    my $this = shift;
    $this->{CHECK_INVENTORY}->($this);
}

sub ship {
    my $this = shift;
    $this->{SHIP}->($this);
}

sub process {
    my $this = shift;

    $this->{CHECK_CREDIT}->($this);
    $this->{CHECK_INVENTORY}->($this);
    $this->{SHIP}->($this);
}
1;


