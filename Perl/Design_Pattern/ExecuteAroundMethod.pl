use strict;
use warnings;
use Carp;

use feature qw(say);

##############################################################################
# 1. You have a pair of operation that needs to be performed beforer and after
#    operations
# 2. You have a resource that needs to be opened/connected to and then
#    safely/automatically closed.
# 3. You want deterministic control of when resource is deallocated (after
#    all you can't relay on the finallizer (DESTROY method)
##############################################################################
package Resource;

use strict;
use warnings;
use Carp;

# This is the way to declare a static class method.
# To enable access to the variable $create we have to us 'our'.
our $create = sub  {
    my $closure = shift;

    say qq|Static class method 'create' ...|;
    die 'First parameter must be a closure!' if (ref($closure) ne 'CODE');

    my $res = Resource->new();
    $res->open();
    $closure->($res);
    return;
};


#----------------------------------------------------------------
# Constructor
#----------------------------------------------------------------
sub new {
    my $class = shift;

    return bless {}, $class;
}

#----------------------------------------------------------------
# Private method. Open a resource ...
#----------------------------------------------------------------
sub open {
    die "_private_sub is private!" unless caller eq __PACKAGE__;
    my $self = shift;
    say 'opened ... ';
    return;
}

#----------------------------------------------------------------
# Private method. Close the resource ...
#----------------------------------------------------------------
sub close {
    die "_private_sub is private!" unless caller eq __PACKAGE__;
    my $self = shift;
    say 'closed ... ';
    return;
}

#----------------------------------------------------------------
# Public method.
#----------------------------------------------------------------
sub operation1 {
    my $self = shift;
    say 'operation1 ... ';
    return;
}

#----------------------------------------------------------------
# Public method.
#----------------------------------------------------------------
sub operation2 {
    my $self = shift;
    say 'operation2 ... ';
    return;
}

#----------------------------------------------------------------
# Destructor.
#----------------------------------------------------------------
sub DESTROY {
    my $self = shift;
    $self->close();
}

#############################################################################
# Run our program in main package.
#############################################################################
package main;

#----------------------------------------------------------------
# Define closure wich get the Resource object as parameter.
# Then inside the closure you can execute the public methods
# of Resource class.
#----------------------------------------------------------------
my $closure = sub {
    my $res = shift;

    $res->operation1();
    $res->operation1();

    return;
};

# Access to static class methode via class variable $create
$Resource::create->($closure);


say 'Before END';
