use strict;
use Test::More 'no_plan';

#----------------------------------------------------------------------
# Purpose: Work with regular expressions
#
# Modifikatoren

# In allen RegEx-Varianten kannst du sogenannte Modifikatoren setzen und damit das genaue Verhalten des Ausdrucks kontrollieren.
# In Java kannst du dies z.B. bei der Konstruktion eines matcher-Objektes erledigen, bei PHP hat ein regulärer Ausdruck immer die Syntax
#
# [Begrenzungszeichen][RegEx][Begrenzungszeichen][Modifikator(en)]
#
# also z.B.
#     /(Mein|Ausdruck)/im
#
# Dabei sind die Slashes die Begrenzungszeichen (andere sind hier denkbar, z.B. ~), und "i" und "m" in diesem Fall Modifikatoren.
# Gängige Modifikatoren sind unter anderem:
#
#     i Case-Insensitivity (die Nichtbeachtung von Groß- und Kleinschreibung) einschalten
#     s Punkt wird multilinefähig: Der Punkt frisst auch Zeilenumbrüche, dies ist standardmäßig nicht so.
#     m Zeilenmodus: Die Zeichen ^ und $ matchen auch auf Zeilenanfänge bzw. -enden. Ohne den Modifikator passen sie nur auf Anfang und Ende der gesamten Zeichenkette.
#
# Modifikatoren beziehen sich immer auf den ganzen Ausdruck und sind daher eine leicht übersehene Fehlerquelle.
#
#----------------------------------------------------------------------

sub find_number {
    my ($track) = @_;

    $track =~ /(\d+)/;
    my $hit = $1;
    return $hit;
}

sub find_number_global {
    my ($track) = @_;

    $track =~ /\D(\d+)/g;
    my $hit = $1;
    return $hit;
}

#-----------------------------------------------------------------------
# Here start the tests
#-----------------------------------------------------------------------
subtest 'Regular Expression assing matched result to variable $1' => sub {

    plan tests => 2;

    is( find_number("We're going to party like it's 1999! (  Prince?)\n"),
        1999, 'year found' );
    is(
        find_number_global(
            "We're going to party like it's 1999! (  Prince?)\n"),
        1999,
        'year found'
    );

};

1;
