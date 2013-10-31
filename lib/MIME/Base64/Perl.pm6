use v6;
class MIME::Base64::Perl;

# 6 bit encoding - 64 characters needed
my @encoding-chars = 'A'..'Z','a'..'z','0'..'9','+','/';

my %decode-values;
for 0..63 -> $i {
    %decode-values{@encoding-chars[$i]} = $i;
}

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
    my @decoded;
    
    my $extra;
    my $spaceleft = 8;
    my $padcount = 0;
    for $encoded.comb -> $char {
        my $val = %decode-values{$char};
        if $val ~~ Int {
            if $spaceleft == 8 {
                # grab the first 6 bits
                $spaceleft = 2;
                $extra = $val +< 2;
            } elsif $spaceleft == 2 {
                # grab the top two bits, complete a byte...
                @decoded.push($extra +| (($val +& 0x30) +> 4));

                # and start the next byte with the 4 remaining bits
                $spaceleft = 4;
                $extra = ($val +& 0x0F) +< 4;
            } elsif $spaceleft == 4 {
                # grab the top 4 bits, complete a byte...
                @decoded.push($extra +| (($val +& 0x3C) +> 2));

                # and start the next byte with the 2 remaining bits
                $spaceleft = 6;
                $extra = ($val +& 0x03) +< 6;
            } elsif $spaceleft == 6 {
                # complete a byte with a 6-bit char
                @decoded.push($extra +| $val);
                $spaceleft = 8;
            }
        }
        if $char eq '=' {
            $padcount++;
        }
    }
    return Buf.new(@decoded);
}
