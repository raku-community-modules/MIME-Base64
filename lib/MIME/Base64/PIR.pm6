use v6;
class MIME::Base64::PIR;

# load the MIME Base64 Parrot library to do all the hard work for us
if $*VM<name> eq 'parrot' {
    EVAL "pir::load_bytecode__vs('MIME/Base64.pbc');";
}

# a little hacky - apparently because the parrot library only runs on strings

method encode(Blob $data, :$oneline --> Str) {
    if $*VM<name> ne 'parrot' {
        die 'Needs parrot backend.';
    }
    my $str = $data.decode('utf8');

    my $encoded-str = EVAL q|nqp::p6box_s Q:PIR {
        .local pmc encode
        encode = get_root_global ['parrot'; 'MIME'; 'Base64'], 'encode_base64'
        $P0 = find_lex '$str'
        $S0 = repr_unbox_str $P0
        %r = encode($S0)
    }|;

    if $oneline {
        $encoded-str ~~ s:g/\n//;
    }

    return $encoded-str;
}

method decode(Str $encoded --> Buf) {
    if $*VM<name> ne 'parrot' {
        die 'Needs parrot backend.';
    }
    my $decoded-str = EVAL q|nqp::p6box_s Q:PIR {
        .local pmc decode
        decode = get_root_global ['parrot'; 'MIME'; 'Base64'], 'decode_base64'
        $P0 = find_lex '$encoded'
        $S0 = repr_unbox_str $P0
        %r = decode($S0)
    }|;

    return Buf.new($decoded-str.encode('ascii'));
}
