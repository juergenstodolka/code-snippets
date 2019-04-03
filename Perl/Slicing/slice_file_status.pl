use strict;
use warnings;
use Test::More 'no_plan';

BEGIN {
  use_ok('Readonly');
}

# Simple arrays can also be useful when refactoring the keys or indices of a single slice:
# This is the order in which stat( ) returns its information:
Readonly my @STAT_FIELDS
    => qw( dev ino mode nlink uid gid rdev size atime mtime ctime blksize blocks );

sub status_for {
    my ($file) = @_;
 
    # The hash to be returned...
    my %stat_hash = ( file => $file );

    # Load each stat datum into an appropriately named entry of the hash...
    @stat_hash{@STAT_FIELDS} = stat $file;
    return \%stat_hash;
}

# and later...
Readonly my $file => $0;
warn qq{File $file was last modified at }, status_for($file)->{mtime};


1;

