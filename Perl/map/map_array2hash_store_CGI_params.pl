use strict;
use warnings;
use Data::Dumper;

# A hash is often the most convenient way to store input parameters to a program
# or subroutine, and map is often the most convenient way to create the parameter hash.
use CGI qw(param);

my $q = new CGI;

my %params = map { $_, ( $q->param($_) )[0] } 
             grep { lc($_) ne 'submit' } $q->param();

print Data::Dumper->Dump([\%params],[qw(params)]);

# The param() call returns a list of CGI parameter names; 
# the param($_) call returns the CGI parameter value for a name.
# If the param($_) call returns multiple values for a CGI parameter, 
# the ( param($_) )[0] syntax extracts only the first value so that the hash
# is still well-defined. 
# Map's block could be modified to issue a warning message for multi-valued
#  parameters.