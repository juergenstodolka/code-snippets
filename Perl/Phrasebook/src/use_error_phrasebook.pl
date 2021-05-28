use strict;
use warnings;


use Class::Phrasebook;
use Log::LogLite;

my $language = $ARGV[0] || 'EN';

my $ERROR_LOG_LEVEL = 6;
my $log = Log::LogLite->new('../log/phrasebook.log', $ERROR_LOG_LEVEL);

my $msg = new Class::Phrasebook($log, "errors.xml");
$msg->load($language);

# check that the name of the document is not a manual_template name
my $template_name = 'XYZ.doc';

if (is_manual_template_name($template_name)) {
    my $message = $msg->get("MISUSE_OF_MANUAL_TEMPLATE_NAME",
                            { name => "$template_name"} ); 
    $log->write($message, 5);
}


sub is_manual_template_name {
    my $filename = shift;
    return $filename ? 1 : 0;
}

1;

__END__

