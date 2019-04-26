use strict;
use Carp;
use Data::Dumper;

my @lines = (
 '<span style="font-size: 10pt;">Abteilung / Department / Jürgen Stodolka</span><br />',
 '<img width=189 height=95 src="SAMSOMATIC_01.jpg" alt="Image_01" /></p>',
 '<img src="SAMSOMATIC_02.jpg"',
);

print Data::Dumper->Dump([\@lines],[qw(lines)]);

#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
sub insert_embedded_html_img_tag {
    my (%arg) = @_;

    my $fct = (caller(0))[3];

    #---------------------------------------------------------------------
    # Purpose:  : Define a closure that is executed for each HTML line.
    # Parameter : one HTML line
    # Return    : ['the modified line', 'image name stored in <img> tag']
    #---------------------------------------------------------------------
    my $img_substitute_closure  = sub {
        my ($line) = @_;

#        if ($line =~ /<img\s+src=\\"(.*?)\\"/xims) {
        if ($line =~ /^<img(.*)src="(.*?)"/xims) {
            my $src_file = $2;
            my $cid      = qq{cid:$src_file};
            (my $new_line = $line) =~ s/src=\\"(.*?)\\"/src=\"$cid\"/;
            return [$new_line, $src_file];
        }
        return [$line, undef];
    };

     # Validation
     my $function;
    if ( ref($arg{substitute})  eq 'CODE') {
        $function = $arg{substitute};
    }
    else {
        $function = $img_substitute_closure;
    }

     if ( ref($function) ne 'CODE' ) {
        die "ERROR: Hash key 'substitute' has to be a function.";
     }
     
     my @html_body = map { $function->($_) } @{$arg{html}};

     return @html_body;
}


print '-' x 80 . "\n";
my @html_body_result = insert_embedded_html_img_tag(html => \@lines);
print Data::Dumper->Dump([\@html_body_result],[qw(html_body_result)]);