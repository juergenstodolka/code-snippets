use strict;
use warnings;

##############################################################################
# Command pattern.
##############################################################################


##############################################################################
# Pass command and undo command in the constructor
##############################################################################
package Command;

use strict;
use warnings;
use Carp;

sub new {
    my $class = shift;

    my $command  = shift;
    if ( ref($command) ne 'CODE') {
        croak "Parameter must be CODE reference!";
    }

    my $undo_command  = shift;
    if ( ref($undo_command) ne 'CODE') {
        croak "Parameter must be CODE reference!";
    }

    # bless the closure
   return bless {
                 command      => $command,
                 undo_command => $undo_command
                }, $class;
}

sub do_command {
    my $self = shift;
    $self->{command}->();
}

sub undo_command {
    my $self = shift;
    $self->{undo_command}->();
}

sub DESTROY {
    my $self = shift;
}

#############################################################################
package main;

sub print_line { print $_[0] . "\n"};

my $count = 0;

# Command to execute
my $do_closure   = sub { $count++; };
my $undo_closure = sub { $count--; };

# Store commands into an array.
sub upto  {
    my $upto = shift;
	$upto ||= 1;
	
	my @commands;
	
    for (my $i=0; $i < $upto; $i++) {
        my $command = Command->new($do_closure, $undo_closure);
        push @commands, $command;
    }
	
	return @commands;
}

# Create 10 Command objects with command and undo command instruction.
my @commands = upto(10);
print_line("count is initially $count");
map { $_->do_command() } @commands;
print_line("did all commands, count is $count");

map { $_->undo_command() } @commands;
print_line("undid all commands, count is $count");


map { $_->do_command() } @commands;
print_line("redid all commands, count is $count");


