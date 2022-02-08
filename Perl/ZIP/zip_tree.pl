use strict;

use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
use Carp;
use Cwd;
use Data::Dumper;
use File::Basename;
use File::Copy;
use File::Path;
use File::Spec;
use List::Util qw(reduce);
use Time::HiRes qw(gettimeofday time);


exit main();

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
sub get_test_data {
    return (
        { dir => '.',           file => 'cocina_completa.dwg', alias => 'COCINA_1.dwg' },        
        { dir => 'lib',         file => 'task.js',        alias => 'NODE_1.js'},
        { dir => 'test',        file => 'first_test.js',  alias => 'NODE_2.js' },
        { dir => 'test/source', file => 'worker.js',      alias => 'NODE_3.js' },
        { dir => '.',           file => 'kandinsky1.pdf', alias => 'ART_1.pdf' },
        { dir => '.',           file => '17.dwg',         alias => 'CocinaBig_1.dwg' }, 
        { dir => '.',           file => '87.dwg',         alias => 'COOKING_1.dwg' },
        { dir => '.',           file => '18.dwg',         alias => 'CocinaBig_2.dwg' },        
        { dir => '.',           file => '89.dwg',         alias => 'COOKING_2.dwg' },
        { dir => '.',           file => '102.dwg',        alias => 'COOKING_3.dwg' },        
    );
}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
sub main {

    my $MAX_MAIL_SIZE = 10_000_000;  # Bytes allowed as mail attachment.

    my $root_dir = File::Spec->catdir( $ENV{HOMEPATH}, 'Software', 'Perl', 'ZIP' );
    print qq|ROOT_DIR=$root_dir\n|;

    my @data = get_test_data();

    print Data::Dumper->Dump( [ \@data ], [qw(data)] );

    my $zip_filename = "ZENDTO_" . now() . '.zip';

    my $t0 = time;
    # Create on Zip archive
   # create_zip_file( $root_dir, \@data, $zip_filename );
    my $t1 = time;

   # my $sizes_aref = get_zip_member_sizes($zip_filename);
    my $t2 = time;

    # Create multiple Zip archives, if sum of files excess MAX_MAIL_SIZE.
    my $zip_file_basename = "ZENDTO_" . now();
    my ($zip_files_aref, $error_msg) = create_multiple_zip_files( $root_dir, \@data, $zip_file_basename, $MAX_MAIL_SIZE);

    print '-' x 80 . "\n";
    print Data::Dumper->Dump( [ $zip_files_aref ], [qw(zip_files_aref)] );

    my $t3 = time;

   # print 'Elapsed time create_zip_file(): ' . ($t1 - $t0) . "\n";
   # print 'Elapsed time get_zip_member_sizes(): ' . ($t2 - $t1) . "\n";
    print '-' x 80 . "\n";
    print 'Elapsed time create_multiple_zip_files(): ' . ($t3 - $t2) . "\n";
   # print Data::Dumper->Dump( [ $sizes_aref ], [qw(sizes_aref)] );

    # my $total_uncompressed_size =
    #      reduce { $a + $b }
    #      map { $_->{uncompressedSize} } @$sizes_aref;

    # my $total_compressed_size =
    #      reduce { $a + $b }
    #      map { $_->{compressedSize} } @$sizes_aref;

    #print "\nTotal compressed size (Bytes/KBytes)  : $total_compressed_size/" . ($total_compressed_size/1024) .  "\n";
    #print "\nTotal uncompressed size (Bytes/KBytes): $total_uncompressed_size/" . ($total_compressed_size/1024) . "\n";

    return 0;
}


#--------------------------------------------------------------------
#--------------------------------------------------------------------
sub now {
    my ($secs, $msecs) = gettimeofday;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($secs);
    return sprintf("%04d-%02d-%02dT%02d_%02d_%02d.%03d",
        1900+$year, 1+$mon, $mday, $hour, $min, $sec, $msecs/1000);
}


#----------------------------------------------------------------------------
# Purpose  : Create a ZIP file. A given subdirectory is added to the ZIP file.
# Parameter: $root_dir     - change to this directory to pack subdirectory
#            $data_aref    - subdirectories/filenames relative to $rootdir
#            $zip_filename - ZIP filename (including extension) is stored in $root_dir
# Return   : array ($zip_file, $error) - if $zip_file is undef, Zip file
#            could not be created.
#----------------------------------------------------------------------------
sub create_zip_file {
    my ( $root_dir, $data_aref, $zip_filename ) = @_;

    if ( !-d $root_dir ) {
        confess('First function parameter must be a directory path!');
    }

    if ( !$zip_filename ) {
        confess('Third function parameter must be a zip filename!');
    }

    my $Fct = ( caller(0) )[3];

    my $orig_dir  = cwd();    # Save current working dir
    my $error_msg = qq{};
    my $zip_file;

    eval {
        chdir($root_dir);
        my $current_date = now();

        # Add subdirectory to zip file
        my $zip = Archive::Zip->new();

        foreach my $item (@$data_aref) {
            
            my $member_name = $item->{dir} . '/' . $item->{file};
            
            $member_name = $zip->addFile($member_name, $item->{alias}, COMPRESSION_LEVEL_DEFAULT )
              or warn "Can't add file $member_name\n";

            my $added_file = File::Spec->catdir( $item->{dir}, $item->{file} );
            print "File added to Zip archive: $added_file\n";
            print '-' x 80 . "\n";

        }

        # Save the Zip file
        if ( $zip->writeToFileNamed($zip_filename) != AZ_OK ) {
            confess 'write error';
        }

        $zip_file = File::Spec->catfile( $root_dir, $zip_filename );
        if ( -e $zip_file ) {
            $error_msg = "ZIP file created:[$zip_file]";
        }
        else {
            $error_msg =
              "ZIP file creation failed. ZIP file not accessible.: [$zip_file]";
            $zip_file = undef;
        }
    };

    if ($@) {
        my $exception = $@;
        my $error_msg = "Exception caught: $exception";
        print "$Fct [E] $error_msg";
        chdir($orig_dir);    # restore original working directory

        return ( undef, $error_msg );
    }

    chdir($orig_dir);        # restore original working directory

    return ( $zip_file, $error_msg );
}

#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
sub zip_filename {
    my ($zip_file_basename) = @_;

    my $counter = 0;

    return sub {
        my $zip_filename =  $zip_file_basename . '_' . $counter . '.zip';
        $counter++;
        return $zip_filename;
    }
}

#----------------------------------------------------------------------------
# Purpose  : Create multiple ZIP files. Create a new one if zip file size
#            exceeds $MAX_MAIL_SIZE/1.37 (Base64 factor).
# Parameter: $root_dir     - change to this directory to pack subdirectory
#            $data_aref    - subdirectories/filenames relative to $rootdir and alias name
#            $zip_file_basename - ZIP file basename (no extension) is stored in $root_dir
#            $MAX_MAIL_SIZE   - Limit (bytes) of all attachments
# Return   : array reference, each item is a hash ref 
#              { file => <filename> , use_as_attachment => 0|1 }
#----------------------------------------------------------------------------
sub create_multiple_zip_files {
    my ( $root_dir, $data_aref, $zip_file_basename, $MAX_MAIL_SIZE ) = @_;

    if ( !-d $root_dir ) {
        confess('First function parameter must be a directory path!');
    }

    if ( ref($data_aref) ne 'ARRAY' ) {
        confess('Second function parameter must be an array reference !');
    }

    if ( !$zip_file_basename ) {
        confess('Third function parameter must be a zip filename!');
    }

    if ( ! $MAX_MAIL_SIZE ) {
        confess('Fourth function parameter must be MAX_MAIL_SIZE!');
    }

    my $fct = ( caller(0) )[3];
    my $error_msg = qq{};
    my $BASE64_FACTOR = 1.37;
    my $MAX_MAIL_SIZE_BASE = $MAX_MAIL_SIZE / $BASE64_FACTOR;
    my $zip_file;
    my @zip_files;
    my $compression_level = COMPRESSION_LEVEL_DEFAULT;

    my $orig_dir  = cwd();    # Save current working dir

    eval {
        chdir($root_dir);

        my $zip = Archive::Zip->new();
        my $zip_sum_file_size = 0;
        my $current_date = now();

        my $get_zip_filename = zip_filename($zip_file_basename); 
        my $zip_filename = $get_zip_filename->();

        for (my $i = 0; $i <= $#$data_aref; $i++) {
        #foreach my $item (@$data_aref) {

            my $item = $data_aref->[$i];
            my $member_name = $item->{dir} . '/' . $item->{file};
            my $size = (stat $member_name)[7];
            print "File size of $member_name: $size \n";

            if ($zip_sum_file_size == 0) {
  
                print "  Add file to Zip archive [$zip_filename:] " . $item->{file} . "\n";
                
                my $member = $zip->addFile($member_name, $item->{alias}, $compression_level )
                    or warn "Can't add file $member_name\n";

                # Save the Zip file
                if ( $zip->writeToFileNamed($zip_filename) != AZ_OK ) {
                    confess 'write error';
                }

                my $zip_size = (stat $zip_filename)[7];

                if ( $zip_size > $MAX_MAIL_SIZE_BASE) {
                    print "$zip_filename is greater than MAX_MAIL_SIZE. Don't attach it to mail.\n";

                    push @zip_files, { file => $zip_filename, use_as_attachment => 0};

                    $zip_sum_file_size = 0;
                    $zip_filename =  $get_zip_filename->();                             
                    print "Create next Zip archive $zip_filename\n";

                    $zip = Archive::Zip->new();
                }
                else {
                    if ( $i == $#$data_aref) {
                        # last element
                        push @zip_files, { file => $zip_filename, use_as_attachment => 1}; 
                    }
                    $zip_sum_file_size += $zip_size;
                }              
 
            }
            elsif ( $zip_sum_file_size > 0) {

                # Open existing Zip archive to overwrite with additional file
                $zip = Archive::Zip->new();
                $zip->read($zip_filename);   # read file contents

                # Zip archive stores already files.
                print "  Add file to Zip archive [$zip_filename:] " . $item->{file} . "\n";

                my $member = $zip->addFile($member_name, $item->{alias}, $compression_level )
                    or warn "Can't add file $member_name\n";                
                
                # Overwrite the Zip file
                if ( $zip->overwrite() != AZ_OK ) {
                    confess 'overwrite error';
                }

                my $zip_size = (stat $zip_filename)[7];
                if ( $zip_size > $MAX_MAIL_SIZE_BASE ) {
                    print "$zip_filename is greater than MAX_MAIL_SIZE.\n";

                     # Open existing Zip archive, remove last file
                    $zip = Archive::Zip->new();
                    $zip->read($zip_filename);   # read file contents^
                    
                    print "Remove file " . $item->{alias}  . " from $zip_filename.\n";
                    my $member = $zip->memberNamed($item->{alias});
                    $zip->removeMember($member);

                    if ( $zip->overwrite() != AZ_OK ) {
                        confess 'overwrite error';
                    }
                    push @zip_files, { file => $zip_filename, use_as_attachment => 1};

                    $zip_sum_file_size = 0;
                
                    $zip_filename =  $get_zip_filename->();
                    print "---> Create next Zip archive $zip_filename\n";

                    $zip = Archive::Zip->new();

                    $member = $zip->addFile($member_name, $item->{alias}, COMPRESSION_LEVEL_DEFAULT )
                        or warn "Can't add file $member_name\n"; 

                    # Save the Zip file
                    if ( $zip->writeToFileNamed($zip_filename) != AZ_OK ) {
                        confess 'write error';
                    }    

                    # Check if it fits to new Zip archive
                    my $zip_size = (stat $zip_filename)[7];
                    if ( $zip_size > $MAX_MAIL_SIZE_BASE) {
                        print "$zip_filename is greater than MAX_MAIL_SIZE. Don't attach it to mail\n";
                        push @zip_files, { file => $zip_filename, use_as_attachment => 0};                        
                        $zip_sum_file_size = 0;
                
                        $zip_filename =  $get_zip_filename->();
                        print "---> Create next Zip archive $zip_filename\n";

                        $zip = Archive::Zip->new();
                    }
                    else {
                        if ( $i == $#$data_aref) {
                            # last element
                            push @zip_files, { file => $zip_filename, use_as_attachment => 1}; 
                        }
                        $zip_sum_file_size += $zip_size;
                    }
                }
                else {
                    print "We can add another file to $zip_filename.\n";
                    $zip_sum_file_size += $zip_size;
                }
            }
            else {
                print "Something forgotten ...???\n";
            }
        }
    };

    if ($@) {
        my $exception = $@;
        my $error_msg = "Exception caught: $exception";
        print "$fct [E] $error_msg";
        chdir($orig_dir);    # restore original working directory

        return ( undef, $error_msg );
    }

    chdir($orig_dir);        # restore original working directory

    return ( \@zip_files, $error_msg );
}


#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
sub get_zip_member_sizes {
    my ($filename) = @_;

    # Read in the ZIP file    
    my $zip = Archive::Zip->new();
    unless ($zip->read($filename) == AZ_OK) {
        die "Read error\n";
    }

    # Loop through the members, getting their name,
    # compressed size, and uncompressed size.
    my @sizes;

    my @members = $zip->members();
    foreach (@members) {
        push @sizes, { 
            filename         => $_->fileName(), 
            compressedSize   => $_->compressedSize(),
            uncompressedSize => $_->uncompressedSize()
        };
    }

    return \@sizes;
}

#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
sub get_zip_compressed_member_sizes_sum {
    my ($filename) = @_;

    # Read in the ZIP file    
    my $zip = Archive::Zip->new();
    unless ($zip->read($filename) == AZ_OK) {
        die "Read error\n";
    }

    # Loop through the members, get their uncompressed size.
    my @sizes;

    my $sum = 0;
    my @members = $zip->members();

    foreach ( @members ) {
        $sum += $_->compressedSize();
    };

    return $sum;
}


#------------------------------------------------------------------
#------------------------------------------------------------------
sub print_zip_member {
    my ($member) = @_;

    return if ( !$member) ;

    print " - " . $member->fileName() . ": " . $member->compressedSize() .
      " (" . $member->uncompressedSize() . ")\n";
}

1;
