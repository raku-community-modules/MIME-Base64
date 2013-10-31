use v6;
class MIME::Base64::Perl;

method encode(Blob $data --> Str){
    die "perl version of MIME::Base64 NYI";
}

method decode(Str $encoded --> Buf){
    die "perl version of MIME::Base64 NYI";
}
