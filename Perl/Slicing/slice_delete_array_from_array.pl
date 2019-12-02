use strict;

my @db = qw(aaa bbb ccc ddd eee fff);
my @in = qw(aaa fff);
my %h;
my @copy = @db;

# Initialise the hash using a slice
@h{@in} = undef;

print  qq|Original array: [@db]\n|;
print  qq|Delete these elements from original array: [@in]\n|;

@db = grep {not exists $h{$_}} @db;

print qq|Result: [@db]\n|;

print qq|Copy of original array: [@copy]\n|;
1;