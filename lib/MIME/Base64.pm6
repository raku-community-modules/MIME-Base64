use v6;

class MIME::Base64:auth<cpan:SNARKY>:ver<1.1> {
    my $actual;

    BEGIN {
        if $*VM<name> eq 'parrot' {
            require MIME::Base64::PIR;
        } else {
            require MIME::Base64::Perl;
        }
    }

    if $*VM<name> eq 'parrot' {
        $actual = MIME::Base64::PIR;
    } else {
        $actual = MIME::Base64::Perl;
    }

    method encode_base64(Str $str) {
        return $actual.encode_base64($str);
    }

    method decode_base64(Str $str) {
        return $actual.decode_base64($str);
    }
}
