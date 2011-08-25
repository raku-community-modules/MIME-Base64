class MIME::Base64:auth<cpan:SNARKY>:ver<1.0> {

    # load the MIME Base64 Parrot library to do all the hard work for us
    pir::load_bytecode('MIME/Base64.pbc');

    method encode_base64(Str $str) {
        my $encoded-str = nqp::p6box_s Q:PIR {
            .local pmc encode
            encode = get_root_global ['parrot'; 'MIME'; 'Base64'], 'encode_base64'
            $P0 = find_lex '$str'
            $S0 = repr_unbox_str $P0
            %r = encode($S0)
        };

        return $encoded-str;
    }

    method decode_base64(Str $str) {
        my $decoded-str = nqp::p6box_s Q:PIR {
            .local pmc decode
            decode = get_root_global ['parrot'; 'MIME'; 'Base64'], 'decode_base64'
            $P0 = find_lex '$str'
            $S0 = repr_unbox_str $P0
            %r = decode($S0)
        };

        return $decoded-str;
    }
}
