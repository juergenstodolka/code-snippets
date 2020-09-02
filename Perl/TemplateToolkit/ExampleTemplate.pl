#-----------------------------------------------------------------------------
# Example form: https://perlmaven.com/template-toolkit
#
# Template::Toolkit is an awesome Perl module to combine data with text
#  or HTML templates to generate pages . It has excellent documentation,
#  but it is always nice to see simple but working examples that you can copy-
#  and -paste and start tweaking.
#
# Let me point out the empty rows between the languages.
# They are there because TT by defaults add a newline at the end of the tag we are inlcuing.
# You can change this by adding a dash at the closing part of the expression.
# This is what happened in the rows of the People where on line 15 you can see
#  a dash before the last percentage sign: -%].
#-----------------------------------------------------------------------------
package ExampleTemplate;

use strict;
use warnings;
use Template;

our $VERSION = 1.0;

my $tt = Template->new(
    {
        INCLUDE_PATH => './templates',
        INTERPOLATE  => 1,
    }
) or die "$Template::ERROR\n";

# These data will be inserted into template defined in file templates/report.tt
my %data = (
    title     => 'This is your title',
    languages => [ 'English', 'Spanish', 'Hungarian', 'Hebrew' ],
    people    => [
        { name => 'Foo', email => 'foo@perlmaven.com' },
        { name => 'Zorg' },
        { name => 'Bar', email => 'Bar@perlmaven.com' },
    ],
);

# Fill template with data
my $report;
$tt->process( 'report.tt', \%data, \$report ) or die $tt->error(), "\n";

# Print report
print $report;

1;
