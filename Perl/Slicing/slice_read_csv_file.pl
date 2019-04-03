use Data::Dumper;

#read header row. 
chomp ( my @header = split /,/, <DATA> ); 

my @rows; 

#iterate other rows
while ( <DATA> ) {  
   chomp;
   my %row;
   #use hash slice to insert into named values. 
   @row{@header} = split /,/; 
   #push this row into the larger data structure. 
   push @rows, \%row; 
}

print Dumper \@rows; 

__DATA__
field1,field2,field3
value,anothervalue,someothervalues
fish,bird,carrot
