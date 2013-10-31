use v6;
class MIME::Base64::Perl;

# 6 bit encoding - 64 characters needed
my @encoding-chars = 'A'..'Z','a'..'z','0'..'9','+','/';

method encode(Blob $data --> Str){
    my $encoded = '';
    for $data.list -> $byte1, $byte2?, $byte3? {
        # first 6 bits of 1
        $encoded ~= @encoding-chars[($byte1 +& 0xFC) +> 2];
        if $byte2 {
            # last 2 bits of 1, first 4 of 2
            $encoded ~= @encoding-chars[(($byte1 +& 0x03) +< 4) +| (($byte2 +& 0xF0) +> 4)];
            if $byte3 {
                # last 4 bits of 2, first 2 of 3
                $encoded ~= @encoding-chars[(($byte2 +& 0x0F) +< 2) +| (($byte3 +& 0xC0) +> 6)];
                # last 6 bits of 3
                $encoded ~= @encoding-chars[$byte3 +& 0x3F];
            } else {
                # last 4 bits of 2 (remaining 2 bits unset)
                $encoded ~= @encoding-chars[($byte2 +& 0x0F) +< 2] ~ '=';
            }
        } else {
            # last 2 bits of 1 (remaining 4 bits unset)
            $encoded ~= @encoding-chars[($byte1 +& 0x03) +< 4] ~ '==';
        }
    }
    return $encoded;
}

method decode(Str $encoded --> Buf){
    die "perl version of MIME::Base64 NYI";
}
