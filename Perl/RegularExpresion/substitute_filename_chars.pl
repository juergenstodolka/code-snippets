use strict;

sub substitute_bad_characters {
    my ($string) = @_;

#-- obsolet JIRA SUE-15791    $string =~ tr/ ,:\/\\*;$%?#><~|/_/;    # substitute 'bad' characters by underline "_"
    $string =~ tr/:\/\\*?><|/_/;    # substitute 'bad' characters by underline "_"
    return $string;
}

my @files = ('This string is allowed', 'This:string\contains?<bad characters>');

foreach my $element (@files) {
  print q|Original string: '|  .  $element . q|'  |;
  print q|After substitute: '| . substitute_bad_characters($element)   . q|'| . "\n";
}

1;