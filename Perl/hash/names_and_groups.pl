#------------------------------------------------------------------------------------
# Tasks:
# * Getting all the groups a person belongs to
# * Getting all the people who belong to a group
#
# If we would like to represent this with Perl data structures we can't do 
# that without lots of repetition. 
# Normally, unless we have a lot of data, this should not be a problem. 
# (If we have too much data we might run out of memory because of the repetitions.) 
#------------------------------------------------------------------------------------

# We create two hashes to allow for the lookup in both directions. 
#
# To fill the %groups_of hash we use the same code as we had earlier.
# That's the easier part as the data in the data file was layed out that way. 
#
# To fill the %members_of needs another internal for-loop that goes over all
# the groups of the current person and adds the person to the right group 
# relying on autovivification to create the references where necessary. 

use 5.010;
use strict;
use warnings;
use Data::Dumper qw(Dumper);
 
my $filename = shift || 'data/name_group.txt';
my %groups_of;
my %members_of;
  
open my $fh, '<', $filename or die "Cannot open file $filename";

while (my $line = <$fh>) {
    chomp $line;
    my ($name, $groups_str) = split /:/, $line;
    my @groups = split /,/, $groups_str;

    $groups_of{ $name  } = \@groups;

    for my $group (@groups) {
        push @{ $members_of{$group} }, $name;
    }
}
 
print Dumper \%groups_of;
say '-------------';
print Dumper \%members_of;

1;