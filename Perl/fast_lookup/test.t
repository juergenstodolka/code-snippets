use strict;
use warnings;
use Data::Dumper;

use FindBin;
use File::Spec;
use lib File::Spec->catdir($FindBin::Bin, 'lib');
 
use Time::HiRes qw(gettimeofday tv_interval);
use Test::More;
     
my @classes = qw(AsArray AsHash AsLinkedList);

plan tests => 14 * scalar @classes;

my $duration;

for my $class (@classes) {
    my $t0 = [gettimeofday];

    eval "use $class";
    is $@, '', "use $class";  

    my $obj = $class->new;
    isa_ok $obj, $class;
    $obj->add('foo', 11);
    $obj->add('bar', 22);
    $obj->add('moo', 33);
    $obj->add('abc', 44);
    $obj->add('def', 55);
    $obj->add('ghi', 66);
    $obj->add('xyz', 77);
    $obj->add('qqq', 88);
    is $obj->count, 8, 'count 8';
  
    my $old = $obj->remove_oldest;
    is $old->{name}, 'foo', 'foo';
  
    $old = $obj->remove_by_name('abc');
    is $old->{name}, 'abc', 'abc';
  
    $old = $obj->remove_oldest;
    is $old->{name}, 'bar', 'bar';
  
    $old = $obj->remove_oldest;
    is $old->{name}, 'moo', 'moo';
  
    $old = $obj->remove_oldest;
    is $old->{name}, 'def', 'def';
  
    $old = $obj->remove_by_name('qqq');
    is $old->{name}, 'qqq', 'qqq';
  
    $obj->add('zzz', 99);
    is $obj->count, 3, 'count 3';
  
    $old = $obj->remove_by_name('xyz');
    is $old->{name}, 'xyz', 'xyz';
  
    $old = $obj->remove_by_name('ghi');
    is $old->{name}, 'ghi', 'ghi';
  
    $old = $obj->remove_oldest;
    is $old->{name}, 'zzz', 'zzz';
    is $obj->count, 0, 'count 0';

    my $elapsed = tv_interval($t0);
    print "Elapsed time: $elapsed\n";
    $duration->{$class} = { elapsed_time => $elapsed };    
}

print Data::Dumper->Dump([$duration], [qw(duration)]);