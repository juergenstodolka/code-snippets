use strict;
use warnings;
use Archive::Zip qw(:ERROR_CODES :CONSTANTS);

my $filename = "ZENDTO_2022-02-07T12_40_14.922.zip";

# Read in the ZIP file    
my $zip = Archive::Zip->new();
unless ($zip->read($filename) == AZ_OK) {
    die "Read error\n";
}

# Loop through the members, printing their name,
# compressed size, and uncompressed size.
my @members = $zip->members();
foreach (@members)
{
    print " - " . $_->fileName() . ": " . $_->compressedSize() .
      " (" . $_->uncompressedSize() . ")\n";
}