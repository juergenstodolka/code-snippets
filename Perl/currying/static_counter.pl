use strict;

use Time::HiRes qw(gettimeofday);


#-----------------------------------------------------------------------------
# Purpose : Returns a function that calculates the same timestamp each time you
#           call this function.
#           If you pass a true value to this function a new timstamp is calculated. 
# Parameter: ---
# Return   : an anonymous function
#-----------------------------------------------------------------------------
sub get_timestamp {

    my ($secs, $msecs) = gettimeofday;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($secs);
    my $timestamp = sprintf("%04d-%02d-%02dT%02d:%02d:%02d.%03d",
                            1900+$year, 1+$mon, $mday, $hour, $min, $sec, $msecs/1000);

    return sub {
	my ($new_timestamp) = @_;

	return $timestamp if ( ! $new_timestamp );

        my ($secs, $msecs) = gettimeofday;
        my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($secs);
        $timestamp = sprintf("%04d-%02d-%02dT%02d:%02d:%02d.%03d",
                            1900+$year, 1+$mon, $mday, $hour, $min, $sec, $msecs/1000);
        return $timestamp;
    };
}

#-----------------------------------------------------------------------------
# Purpose  : Print result of timestamp function.
# Parameter: $timestamp_fref (function reference)
# Return   : ---
#-----------------------------------------------------------------------------
sub print_timestamp {
    my ($timestamp_fref) = @_;

    # Each time we call the timestamp function without parameter,
    # we'll get the same timestamp.
    foreach my $counter (1..3) {
        print $timestamp_fref->() . "\n";
    }

    print '-' x 80 . "\n";
    return;
}

#-----------------------------------------------------------------------------
# Purpose  : Demonstrate local static variable in function (timestamp)
#            by implementing 'currying'. 
#-----------------------------------------------------------------------------
sub main {

    # Get first timestamp 
    my $timestamp_fct = get_timestamp();
    print_timestamp($timestamp_fct);

    # Calculate a new timestamp
    my $calculate_new_timestamp = 1;
    print $timestamp_fct->($calculate_new_timestamp) . "\n";
    print_timestamp($timestamp_fct);

    # Calculate a new timestamp
    print $timestamp_fct->($calculate_new_timestamp) . "\n";
    print_timestamp($timestamp_fct);

    return;
}

main();
