use strict;
use warnings;

use Data::Dumper;
use FindBin qw($Bin);
use lib "$Bin";  # get absolute path o subdirectory 'lib'

use ArrayUtils;


#------------------------------------------------------------------------------
# Define anon function that will be passed to process_array().
# Always an hash is passed to the function for each element.
# The first key 'ele' stores one array element.
# The following parameters are passed to process_array.
#------------------------------------------------------------------------------
my $print_name = sub {
    my (%arg) = @_;

    my $data_href = $arg{ele}; # one array element
	
    my $name      = $data_href->{name} || 'UNDEFINED name';
    my $greeting  = $arg{greeting} || '';

    print "Hello $name!". $greeting ."\n";

    # Copy hash element, modify and return it as result.
    my %data_modified = %$data_href;
    $data_modified{name} = 'printed';

    return \%data_modified;
};

#--- Test data structure: a array whith hash references as elements.
my @data = (
    {
      name => 'Juergen',
      age  => 55,
    },
    {
      name => 'Tini',
      age  => 53,
    },
    {
      name => 'Sarah',
      age  => 19,
    },
);


#----------------------------------------------------------------------------
#- Mix all together. Execute anon function $print_name on each array element.
#----------------------------------------------------------------------------
my $u = ArrayUtils->new();

print 'Original array: ' . Data::Dumper->Dump([\@data], [qw(*data)]);

my @results = $u->process_array($print_name, \@data);

print 'Result array: ' . Data::Dumper->Dump([\@results], [qw(*results)]);
print 'Original array' . Data::Dumper->Dump([\@data], [qw(*data)]);

#-------------------------------------------------------
# Pass additional data as hash
#-------------------------------------------------------
print '-' x 80 . "\n";
$u->process_array($print_name, \@data, 'greeting' => ' How are you?');


#----------------------------------------------------------------------
# Nothing will happen. First parameter is not a function, so it it is
# not applied to an array element.
#----------------------------------------------------------------------

print '-' x 80 . "\n";
$u->process_array('dummy', \@data);

#----------------------------------------------------------------------
# Following calls throw exceptions because of wrong data and/or syntax)
#----------------------------------------------------------------------
print '-' x 80 . "\n";
eval {
   $u->process_array($print_name);
};
if ($@) {
   print "EXCEPTION caught: $@\n";
}

eval {
   $u->process_array(\@data);
};
if ($@) {
   print "EXCEPTION caught: $@\n";
}

eval {
   $u->process_array(\@data, $print_name);
};
if ($@) {
   print "EXCEPTION caught: $@\n";
}

1;