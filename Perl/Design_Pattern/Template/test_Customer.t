use Test::More 'no_plan';

# BEGIN {
#        use_ok (FindBin);
#        use_ok (UsCustomer);
#        use_ok (EuropeanCustomer);
#       }

use strict;

use Data::Dumper;
use FindBin qw($Bin);
use lib "$Bin";
  
sub read_perl_modules {
  my ($file) = @_;

  my $fh;
  open ($fh,"$file");
  
  my @fileData = <$fh>;
  # Leere Zeilen entfernen
  my @FileContent = ();
  map {push @FileContent, $_  if $_ !~ /^\s*$/; } @fileData;
  
  close $fh;  

  return \@FileContent;
}

#--------------------------------------------------------------------
# Read Perl module from file and load it
#--------------------------------------------------------------------
my $perl_modules_aref = read_perl_modules('perl_modules.txt');
foreach my $module (@$perl_modules_aref) {
  eval "$module";  
}


#-- Create new instances that implements the interface from ICustomer.pm
my $us_customer = UsCustomer->new();
my $eu_customer = EuropeanCustomer->new();
isa_ok ( $us_customer, 'UsCustomer');
isa_ok ( $eu_customer, 'EuropeanCustomer');

#-- The process() function of class ICustomer runs the the template functions
#-- CHECK_CREDIT, CHECK_INVENTORY, SHIP which are implemnted in derived classes
#-- Function process() runs three functions implemented in class UsCustomer
$us_customer->process();

#-- Get the results of each template function and validate the strings
like($us_customer->{plan}->[0], qr/checking us customer credit/i , 'first plan check credit');
like($us_customer->{plan}->[1], qr/checking us warehouse/i , 'second plan check inventory' );
like($us_customer->{plan}->[2], qr/Shipping to us address/i, 'third then ship');

#-- Run the template functions
#-- Function process() runs three functions implemented in class EuropeanCustomer
$eu_customer->process();

#-- Get the results of each template function and validate the strings
like($eu_customer->{plan}->[0], qr/checking european customer credit/i , 'first plan check credit');
like($eu_customer->{plan}->[1], qr/checking european warehouse/i , 'second plan check inventory' );
like($eu_customer->{plan}->[2], qr/Shipping to european address/i, 'third then ship');

1;
