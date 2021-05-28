use strict;
use warnings;

use Encode;
use Carp;
use utf8;
use Encode::HanExtra;

# for example, printing to STDOUT

#print encode('UTF-8', $perl_string); # in a Linux environment
#print encode('GB18030', $perl_string); # in a Windows environment

my $file = 'test.txt';
my $fileSystem_Prog = 'utf8-fileSystem-win.exe';

my $rdy_file = 'ABC.rdy';
my $copy_file = 'ÂÎ.txt';
#my $renamed_file = "对象清单对象清单";
my $renamed_file = '你好，张ＨＹ';

if ( -e $file) {
    print "Test external NodeJs exe program $fileSystem_Prog \n";
    my @cmd = ($fileSystem_Prog, '--create', '-f', $rdy_file);
    my $status = system(@cmd);
}

my $start_node_file = 'start_node_exe.bat';

#utf8::encode($rdy_file);
#utf8::encode($copy_file);
#Encode::decode('UTF-8', $copy_file);

print encode('UTF-8', $renamed_file) . "\n"; # in a Linux environment
#print encode('GB18030', $renamed_file) . "\n"; # in a Windows environment

open my $fh, '>:encoding(UTF-8)', $start_node_file or confess "Cannot open $start_node_file: $!";
print $fh  "$fileSystem_Prog --rename -f $rdy_file -o $renamed_file";
close $fh;

# if ( -e $copy_file) {
#    print "Test external NodeJs exe program $fileSystem_Prog \n";
#    my @cmd = ($fileSystem_Prog, '--rename', '-f', $rdy_file, '-o', $copy_file);
#    my $status = system(@cmd);
# }


1;