use strict;
use warnings;
use 5.010;

use Tk;

my $top = MainWindow->new;
my $text = $top->Text( -state => 'disabled' );
$text->pack;

$text->configure( 'state', 'normal' );
$text->Insert("Test key binding (result is printed to STDOUT):\n\n");
$text->Insert("Type <a>\n");
$text->Insert("Type <A>\n");
$text->Insert("Type <Control-a>\n");
$text->Insert("Type <Alt-a>\n");

$text->configure( 'state', 'disabled' );

$top->bind( "<a>",         sub { say 'a pressed' } );
$top->bind( "<A>",         sub { say 'A pressed (shift-a)' } );
$top->bind( "<Control-a>", sub { say 'Ctrl-a pressed' } );
$top->bind( "<Alt-a>",     sub { say 'Alt-a pressed' } );

MainLoop;
