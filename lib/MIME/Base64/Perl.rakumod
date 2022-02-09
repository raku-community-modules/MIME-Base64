unit class MIME::Base64::Perl:auth<zef:raku-community-modules>;

# 6 bit encoding - 64 characters needed
my constant @encoding-chars = <
  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
  a b c d e f g h i j k l m n o p q r s t u v w x y z
  0 1 2 3 4 5 6 7 8 9 + /
>;

my constant %decode-values = (^64).map({ @encoding-chars[$_] => $_ }).Map;

method encode(Blob:D $data, :$oneline --> Str:D){
    my str @chars;
    my int $linelen;
    my int $maxlen  = $oneline ?? 0x7fffffffffffffff !! 76;

    my sub add-byte($b) {
        add-char(@encoding-chars[$b]);
    }

    my sub add-char(str $x) {
        @chars.push($x);
        $linelen++;
        if $linelen >= $maxlen {
            $linelen = 0;
            @chars.push("\n");
        }
    }

    for $data -> $byte1, $byte2?, $byte3? {
        # first 6 bits of 1
        add-byte(($byte1 +& 0xFC) +> 2);
        if $byte2.defined {
            # last 2 bits of 1, first 4 of 2
            add-byte((($byte1 +& 0x03) +< 4) +| (($byte2 +& 0xF0) +> 4));
            if $byte3.defined {
                # last 4 bits of 2, first 2 of 3
                add-byte((($byte2 +& 0x0F) +< 2) +| (($byte3 +& 0xC0) +> 6));
                # last 6 bits of 3
                add-byte($byte3 +& 0x3F);
            }
            else {
                # last 4 bits of 2 (remaining 2 bits unset)
                add-byte(($byte2 +& 0x0F) +< 2);
                add-char('=');
            }
        }
        else {
            # last 2 bits of 1 (remaining 4 bits unset)
            add-byte(($byte1 +& 0x03) +< 4);
            add-char('=');
            add-char('=');
        }
    }
    @chars.join
}

method decode(Str:D $encoded --> Buf:D){
    my $decoded := Buf.new;
    
    my int $extra;
    my int $spaceleft;

    for $encoded.comb -> $char {
        my $val := %decode-values{$char};

        if $val.defined {
            if $spaceleft == 0 {
                # grab the first 6 bits
                $spaceleft = 2;
                $extra = $val +< 2;
            }
            elsif $spaceleft == 2 {
                # grab the top two bits, complete a byte...
                $decoded.push($extra +| (($val +& 0x30) +> 4));

                # and start the next byte with the 4 remaining bits
                $spaceleft = 4;
                $extra = ($val +& 0x0F) +< 4;
            }
            elsif $spaceleft == 4 {
                # grab the top 4 bits, complete a byte...
                $decoded.push($extra +| (($val +& 0x3C) +> 2));

                # and start the next byte with the 2 remaining bits
                $spaceleft = 6;
                $extra = ($val +& 0x03) +< 6;
            }
            elsif $spaceleft == 6 {
                # complete a byte with a 6-bit char
                $decoded.push($extra +| $val);
                $spaceleft = 0;
            }
        }
    }
    $decoded
}

# vim: expandtab shiftwidth=4
