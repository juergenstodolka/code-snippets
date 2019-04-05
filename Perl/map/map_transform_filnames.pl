use strict;
use Data::Dumper;

my @filelist = glob("../*");
my @sizes = map { -s $_ } @filelist;

print "@sizes \n";

my %file_size = map { 
    $_ => { 'is a ' => -d ? 'directory': 'file' ,'size' => -s $_}
} @filelist;

print Data::Dumper->Dump([\%file_size],[qw(file_size)]);