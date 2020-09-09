use strict;
use warnings;

use Tk;

# Create the main window
my $top = MainWindow->new;

# Create a text field and add it to the main window.
# The field cannot be edited. It is read-only.
my $text = $top->Text( -state => 'disabled' );
$text->pack;

# Create a button. On click call the function do_on_click()
# Add button to MainWindow
my $btn = $top->Button(
    -text    => 'Click me',
    -font    => [ 'fixed', 20 ],
    -command => \&do_on_click,
);
$btn->pack;

# Write current localtime string into text field $text.
sub do_on_click {
    $text->configure( 'state', 'normal' );
    $text->Insert( scalar(localtime) . "\n" );
    $text->configure( 'state', 'disabled' );
}

MainLoop;
