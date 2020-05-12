use strict;
use warnings;

## References to lambdas that increment, decrement, and do nothing.
## $_[0] is the argument passed to each lambda.
my $inc = sub { $_[0] + 1 };  ## could use 'return $_[0] + 1' for clarity
my $dec = sub { $_[0] - 1 };  ## ditto
my $nop = sub { $_[0] };      ## ditto

sub trace {
    my ($val, $func, @rest) = @_;
    print $val, " ", $func, " ", join(' ',@rest), "\nHit RETURN to continue...\n";
    <STDIN>;
}

## Apply an operation to a value. The base case occurs when there are
## no further operations in the list named @rest.
sub apply {
    my ($val, $first, @rest) = @_;
 #   trace($val, $first, @rest) if 1;  ## 0 to stop tracing

    return ($val, apply($first->($val), @rest)) if @rest; ## recursive case
    return ($val, $first->($val));                        ## base case
}

sub apply_non_recursive {
    my ($val, $first, @rest) = @_;
 #   trace($val, $first, @rest) if 1;  ## 0 to stop tracing

    my @complete;
    push @complete, $val;

    my $result = $first->($val);
    push @complete, $result;

    return $result if ( scalar @complete == 0 );

    foreach my $func (@rest) {
       my $last    = $result; 
       my $current = $func->($last);
       push @complete, $current;
       $result = $current;
    }

   return @complete;
}


my $init_val = 0;
my @ops = (                        ## list of lambda references
    $inc, $dec, $dec, $inc,
    $inc, $inc, $inc, $dec,
    $nop, $dec, $dec, $nop,
    $nop, $inc, $inc, $nop
    );

## Execute.
print join(' ', apply($init_val, @ops)), "\n";
## Final line of output: 0 1 0 -1 0 1 2 3 2 2 1 0 0 0 1 2 2

print join(' ', apply_non_recursive($init_val, @ops)), "\n";