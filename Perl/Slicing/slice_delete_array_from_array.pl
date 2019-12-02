use strict;

use Data::Dumper;

my @db = qw(aaa bbb ccc ddd eee fff);
my @in = qw(aaa fff);
my %h;
my @copy = @db;

# Initialise the hash using a slice
@h{@in} = undef;

print '-' x 80 . "\n";
print  qq|Original array: [@db]\n|;
print  qq|Delete these elements from original array: [@in]\n|;

@db = grep {not exists $h{$_}} @db;

print qq|Result: [@db]\n|;

print qq|Copy of original array: [@copy]\n|;

print '-' x 80 . "\n";

my @members = (
    { 
        subdir => 11,
        header => { PLS_ORIG_NAME => 'Hill.png'},
        file   => 'Mountain_Picture.png'
    },
    { 
        subdir => 12,
        header => { PLS_ORIG_NAME => 'LemonTree.png'},
        file   => 'LemonTre.png'
    },
    { 
        subdir => 11,
        header => { PLS_ORIG_NAME => 'Hill.png'},
        file   => 'Mountain_Picture.png'
    },
    { 
        subdir => 12,
        header => { PLS_ORIG_NAME => 'River.png'},
        file   => 'Amazonas.png'
    },    
);

#----------------------------------------------------------------------
# We want to delete a more complex data structure
# The condition is: delete all entries that contains 'subdir = 12'
#----------------------------------------------------------------------
my @del = (
    { 
        subdir => 12,
        header => { PLS_ORIG_NAME => 'LemonTree.png'},
        file   => 'LemonTre.png'
    },
    {
        subdir => 12,
        header => { PLS_ORIG_NAME => 'River.png'},
        file   => 'Amazonas.png'
    },
);


print Data::Dumper->Dump([\@members], [qw(*members)]);

# This is a simple case.
@members = grep { $_->{subdir} != 12 } @members;

print '-' x 80 . "\n";
print Data::Dumper->Dump([\@members], [qw(*members)]);

1;