use v6;

use Test;

use lib 'lib';

use MIME::Base64;

plan 9;

my MIME::Base64 $mime .= new;

is $mime.encode_base64(""), '', 'Encoding the empty string';
is $mime.encode_base64("A"), 'QQ==', 'Encoding "A"';
is $mime.encode_base64("Ab"), 'QWI=', 'Encoding "Ab"';
is $mime.encode_base64("Abc"), 'QWJj', 'Encoding "Abc"';
is $mime.encode_base64("Abcd"), 'QWJjZA==', 'Encoding "Abcd"';
is $mime.encode_base64("Perl"), 'UGVybA==', 'Encoding "Perl"';
is $mime.encode_base64("Perl6"), 'UGVybDY=', 'Encoding "Perl6"';
is $mime.encode_base64("Another test!"), 'QW5vdGhlciB0ZXN0IQ==', '"Encoding "Another test!"';
is $mime.encode_base64("username:thisisnotmypassword"), 'dXNlcm5hbWU6dGhpc2lzbm90bXlwYXNzd29yZA==', 'Encoding "username:thisisnotmypassword"';
