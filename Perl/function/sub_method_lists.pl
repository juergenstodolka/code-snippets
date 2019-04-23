#!/usr/local/bin/seppperl -w
#!/usr/local/bin/seppperl -d:ptkdb
###############################################################
#
# 23.06.2015 JS  
#
# Instead of using a lot of if/elsif/else statements we work with
# a dispatch table that stores keys as actions to do.
# The associated values are annonymous function (CODE) which
# executes an individula function. 
###############################################################

use strict;
use warnings;

sub a { 
   print "Function a: @_ \n";
}
sub b {
    my $var = shift; print "Function b: $var \n";
}
sub c {
   my $var = shift; print "Function c: $var \n";
}

sub d {
   my $var = shift; print "Function d: $var \n";
}

#-- Dispatch table
my %process = (
      'make'  => sub { a(@_) },
      'run'   => sub { b(@_) },
      'build' => sub { c(@_) },
      'test'  => \&d,
);

#-- Array @actions stores function in order to run
my @actions = qw (build make test unknown run);

#-- Loop over each action element
foreach (@actions) {
   if (exists $process{$_}) {
       $process{$_}->(1..5)
   }
   else {
       print qq|action '$_'' not available \n|;
   }
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
    print "sub_method_lists.pl AUTOLOAD: function $fct not defined !\n";
    }

1;

