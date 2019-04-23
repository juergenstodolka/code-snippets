use strict;
use warnings;

# Helper function prints one comment line
sub printLine {  print '-' x 80 . "\n";}


printLine();
print qq{Script: [$0]\n};

# Scope is script, outer function
#
printLine();
my $CurrentPackage = (caller(0))[0]; 
my $CurrentFile    = (caller(0))[1]; 
my $CurrentLine    = (caller(0))[2]; 
my $CurrentFct     = (caller(0))[3]; 

$CurrentPackage |= qq{};  # set empty string, if value is 'undef'
$CurrentFile    |= qq{};  # set empty string, if value is 'undef'
$CurrentLine    |= qq{};  # set empty string, if value is 'undef'
$CurrentFct     |= qq{};  # set empty string, if value is 'undef'

print qq{Scope=script\n};
print qq{Package: $CurrentPackage\nFile: $CurrentFile\nLine: $CurrentLine\nFunction: $CurrentFct\n};   # aufgerufene Funktion

printLine();

do_something();

printLine();


#------------------------------------------------------------------------
sub do_something
    {
    my $CurrentPackage = (caller(0))[0]; 
    my $CurrentFile    = (caller(0))[1]; 
    my $CurrentLine    = (caller(0))[2]; 
    my $CurrentFct     = (caller(0))[3];

    print qq{Scope=function\n};
    print qq{Package: $CurrentPackage\nFile: $CurrentFile\nLine: $CurrentLine\nFunction: $CurrentFct\n};   # aufgerufene Funktion

    }

1;


