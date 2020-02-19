package Table {

   sub new { bless {}, $_[0] }
   sub GET { return $_[0]->{x}  }
   sub PUT { $_[0]->{x} = $_[1] }
 
}

package SubTable {

  # Class SubTable is derived from class Table
  use base 'Table';

   sub DELETE { delete $_[0]->{x} }
}

package Dispatcher {

use strict;

  #----------------------------------------------------------------------------
  # Constructor.
  # Parameter: Hash ref with any object
#----------------------------------------------------------------------------  
  sub new {

    my ($class, $args) = @_;
    my $self = bless { obj => $args->{object} }, $class;
  }

  #----------------------------------------------------------------------------
  # Purpose: Search if $method is available for object passed to the contructor.
  #          If the method exist, it will be executed and $data passed to the method.
  # Parameter: $this   - this pointer
  #            $method - method name (string)
  #            $data   - any data
  # Returns  : what $method returns
  # Exception : if $method is unknown an exeption will be thrown.
  #----------------------------------------------------------------------------
  sub execute {
    my ($this, $method, $data) = @_;

    my $obj = $this->{obj};
    if (my $fn = $obj->can($method)) {
        return $obj->$method($data)

        # the following would also work and would be
        # marginally faster
        # $table->$fn($data)
    }
    else {
        die qq|METHOD '$method' NOT ALLOWED!|;
    }
  }

}

#--------------------------------------------------------------------------
# Here we are in Perl's main package.
# Create a SubTable object and pass it to Dispatcher constructor.
# Then call methods from class Table or SubTable.
#--------------------------------------------------------------------------

use Test::More qw(no_plan);
use Test::Exception;

my $table = SubTable->new;
my $d     = Dispatcher->new({object => $table});

my $response = $d->execute('GET');
is ($response, undef, 'First get returns undef');

$response = $d->execute('PUT', 'First data');
is ($response, 'First data', qq|Store data with PUT|);

$response = $d->execute('GET');
is ($response, 'First data', qq|GET returns data stored with PUT|);

$d->execute('DELETE');
$response = $d->execute('GET');
is ($response, undef, 'Stored data deleted');

throws_ok { $d->execute('XXX') } qr/METHOD\s+'XXX'\s+NOT ALLOWED!/, 'Method not allowed in class';

1;