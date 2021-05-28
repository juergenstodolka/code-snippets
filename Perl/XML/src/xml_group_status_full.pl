    #!/usr/bin/perl
    use strict;
    use warnings;
    #
    # Program to count perl monger groups by status.
    #

    # forces a flush after every write or print, so the output appears
    # as soon as it's generated rather than being buffered.
    $|++;

    use XML::XPath;

    my $xp = XML::XPath->new( filename => '../data/perl_mongers.xml' )
      || die 'badness!!';

    my @nodes = $xp->findnodes('/perl_mongers/group');

    my %counts;

    foreach my $node (@nodes) {

        my $status = $node->findvalue('@status');
        $counts{$status}++;

        if ( $status eq 'active' || $status eq 'left' ) {

            my $longitude = $node->findvalue('location/longitude/text()');
            my $latitude  = $node->findvalue('location/latitude/text()');
            my $name      = $node->findvalue('name/text()');
            my $continent = $node->findvalue('location/continent/text()');

            if ($continent) {
                if ( not $longitude ) {
                    print "Longitude missing for $name\n";
                }
                elsif ( not $latitude ) {
                    print "Latitude missing for $name\n";
                }
            }
        }
    }

    my $tot;
    print map { $tot += $counts{$_}; "$_ : $counts{$_}\n" } keys %counts;

    print "\nTotal: $tot\n";

    1;
