#!/usr/local/bin/perl -w
#!/usr/local/bin/perl -d:ptkdb
#
# 20.06.2007 JS  
#
###############################################################

use strict;
use warnings;

#-------------------------------------------------------------
# - Übergabeparameter an eine Funktion in beliebiger Reihenfolge
# - INIT wird nur einmal am Anfang des Ladevorgangs aufgerufen.
# - Die Variable $counter entspricht einer static Variablen.
#-------------------------------------------------------------
INIT
    {
    my $Counter = 0; # static Counter
    my $CurrentFct; 

    sub Run
        {
        my %defaults = ( ZUWACHS => "10",  ZIEL    => 0, START   => 0);
        my %arg = (%defaults ,@_ ); # @ steht die Liste der Argumentenpaare
                                     # fehlen die Übergabeparameter, so werden die aus %defaults vwewendet.
                                     # Sonst überschreibt @_ die Paramter aus %defaults
        if ( $Counter == 0)
            {
            # Print this info once
            my $CurrentPackage = (caller(0))[0]; 
            my $CurrentFile    = (caller(0))[1]; 
            my $CurrentLine    = (caller(0))[2]; 
               $CurrentFct     = (caller(0))[3]; 
            print "Package: $CurrentPackage\nFile: $CurrentFile\nLine: $CurrentLine\nFunction: $CurrentFct\n";   # aufgerufene Funktion
            ++$Counter;    
            }

        print "$CurrentFct: "; 
        if ( $arg{ZUWACHS} =~ /s$/ )
            {
            print "Zuwachs= $arg{ZUWACHS} "; 
            }
        print "Start= $arg{START} "; 
        print "Ziel= $arg{ZIEL}\n\n"; 
        }

    } #---- INIT ----


Run (ZUWACHS => "20s", START => "+5m", ZIEL => "+30m");
Run (START => "+5m", ZIEL => "+30m");
Run (ZIEL => "+5m", START => "+5m");
Run (ZUWACHS => "20s", ZIEL => "+30m");
Run ();
Run (ZUWACHS => "20s", ZUWACHS => "30s");

1;

