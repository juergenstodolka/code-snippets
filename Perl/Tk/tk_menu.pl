use strict;
use warnings;

use Tk;

my $top = MainWindow->new;

my $main_menu = $top->Menu();

# Add pull down menu 'File' to top bar main menu
my $file_menu = $main_menu->cascade( -label => 'File' );

# Add sub menues of 'File'
$file_menu->command( -label => 'Open', -command => \&do_open );
$file_menu->command( -label => 'Quit', -command => sub { exit } );

# Add pull down menu 'Action' to top bar main menu
my $action_menu = $main_menu->cascade( -label => 'Action' );
$action_menu->command( -label => 'Run', -command => \&run );

# Add pull down menu 'Help' to top bar main menu
my $about_menu = $main_menu->cascade( -label => 'Help', -underline => 0 );
$about_menu->command( -label => 'About', -command => \&about );

$top->configure( -menu => $main_menu );

MainLoop;

sub do_open {
    print("open\n");
}

sub run {
    print("run\n");
}

sub about {
    print("about\n");
}
