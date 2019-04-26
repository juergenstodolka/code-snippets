#!/usr/local/bin/seppperl
#!/usr/local/bin/seppperl -d:ptkdb
###############################################################
#
# 13.08.2013 JS  
#
###############################################################

use strict;
# Create a test string
my $string = "  \t  Hello world!   ";

# Here is how to output the trimmed text "Hello world!"
print trim($string)."\n";
print ltrim($string)."\n";
print rtrim($string)."\n";

# Perl trim function to remove whitespace from the start and end of the string
sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}
# Left trim function to remove leading whitespace
sub ltrim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	return $string;
}
# Right trim function to remove trailing whitespace
sub rtrim($)
{
	my $string = shift;
	$string =~ s/\s+$//;
	return $string;
}


#-----------------------------------------------------------------------------
# END block is always called before exit.
#-----------------------------------------------------------------------------
END
    {
    # Last actions like close file/database/sockets etc.
    }

#-----------------------------------------------------------------------------
# Funcion AUTOLOAD is activated, if a function is called which has never been
# defined before.
# Parameters: $_[0]
# Return: 
#-----------------------------------------------------------------------------
sub AUTOLOAD
    {
    my $fct = our $AUTOLOAD;
    print "db_file.pl AUTOLOAD: function $fct not defined !\n";
    }

1;

