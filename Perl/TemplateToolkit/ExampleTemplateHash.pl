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
package ExampleTemplateHash;

use strict;
use warnings;
use Template;

our $VERSION = 1.0;

my %payload = (
    'TylerMontgomery(2022)' => {
        'so'     => 1,
        'bb'     => 1,
        'rbis'   => 0,
        'atbats' => 117,
        'runs'   => 2,
        'hits'   => 2
    },
    'ChaseLangan(2022)' => {
        'runs'   => 4,
        'hits'   => 24,
        'atbats' => 5,
        'bb'     => 0,
        'rbis'   => 2,
        'so'     => 1
    },
    'BryceJones(2021)' => {
        'hits'   => 2,
        'runs'   => 2,
        'atbats' => 4,
        'bb'     => 2,
        'rbis'   => 4,
        'so'     => 1
    },
);

my $tt = Template->new(
    {
        INCLUDE_PATH => './templates',
        INTERPOLATE  => 1,
    }
) or die "$Template::ERROR\n";

my %data = ( payload => \%payload, );

my $report;
$tt->process( 'report_hash.tt', \%data, \$report ) or die $tt->error(), "\n";

print $report;

1;
