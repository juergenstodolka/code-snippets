#!/usr/bin/perl

use strict;

use Crypt::Eksblowfish::Bcrypt;

my $password = 'bigtest';
my $encrypted = encrypt_password($password);

print "$password is encrypted as $encrypted\n";
print "Yes the password is $password\n" if check_password($password, $encrypted);
print "No the password is not smalltest\n" if !check_password('smalltest', $encrypted);

# Encrypt a password 
sub encrypt_password {
    my $password = shift;

    # Generate a salt if one is not passed
    my $salt = shift || salt(); 

    # Encrypt the password 
    my $hash = Crypt::Eksblowfish::Bcrypt::bcrypt_hash({
            key_nul => 1,
            cost => 8,
            salt => $salt,
        }, $password);

    # Return the salt and the encrypted password
    return join('-', $salt, Crypt::Eksblowfish::Bcrypt::en_base64($hash));
}

# Check if the passwords match
sub check_password {
    my ($plain_password, $hashed_password) = @_;
    my ($salt) = split('-', $hashed_password, 2);
    return length $salt == 16 && encrypt_password($plain_password, $salt) eq $hashed_password;
}

# Return a random salt
sub salt {
    my $itoa64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    my $salt = '';
    $salt .= substr($itoa64,int(rand(64)),1) while length($salt) < 16;
    return $salt;
}