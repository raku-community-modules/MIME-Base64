use v6;

class MIME::Base64:auth<cpan:SNARKY>:ver<1.1> {
    my $default-backend;
    has $.backend;

    BEGIN {
        if $*VM<name> eq 'parrot' {
            require MIME::Base64::PIR;
            require MIME::Base64::Perl;
        } else {
            require MIME::Base64::Perl;
        }
    }

    if $*VM<name> eq 'parrot' {
        $default-backend = MIME::Base64::PIR;
    } else {
        $default-backend = MIME::Base64::Perl;
    }

    method new($backend = 0) {
        if $backend ~~ Numeric {
            return self.bless(backend => $default-backend);
        } else {
            return self.bless(backend => $backend);
        }
    }

    method set-backend($class){
        if self {
            self.backend = $class;
        } else {
            $default-backend = $class;
        }
    }

    method get-backend() {
        if self {
            return self.backend;
        } else {
            return $default-backend;
        }
    }

    method encode(Blob $data --> Str) {
        if self {
            return self.backend.encode($data);
        } else {
            return $default-backend.encode($data);
        }
    }

    method decode(Str $encoded --> Buf) {
        if self {
            return self.backend.decode($encoded);
        } else {
            return $default-backend.decode($encoded);
        }
    }

    method encode-str(Str $string --> Str) {
        return self.encode($string.encode('utf8'));
    }

    method decode-str(Str $encoded --> Str) {
        return self.decode($encoded).decode('utf8');
    }

    # compatibility methods
    method encode_base64(Str $str --> Str) {
        return self.encode-str($str);
    }

    method decode_base64(Str $str --> Str) {
        return self.decode-str($str);
    }
}
