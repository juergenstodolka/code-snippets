    use 5.010;
    use strict;
    use warnings;
    use Data::Dumper qw(Dumper);
     
    my $filename = shift || 'data/name_score.txt';
    my %scores_of;
     
    # Read data text file line by line.
    open my $fh, '<', $filename or die;
    while (my $line = <$fh>) {
        chomp $line;
        # Split names and scores
        my ($name, $scores_str) = split /:/, $line;
        # Split scores separated by ','
        my @scores = split /,/, $scores_str;
        $scores_of{ $name  } = \@scores;
    }

    # Print total data structure %scores 
    print Dumper \%scores_of;
    
    say '-------------';
    # Print Mary's scores
    my $name = 'Mary';
    say qq|Maray's scores:|;
    for my $score (@{ $scores_of{ $name } }) {
        say $score;
    }


    1;