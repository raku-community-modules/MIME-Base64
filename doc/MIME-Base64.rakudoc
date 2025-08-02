=begin pod

=head1 NAME

MIME::Base64 - Encoding and decoding Base64 ASCII strings

=head1 SYNOPSIS

=begin code :lang<raku>
use MIME::Base64;

my $encoded = MIME::Base64.encode-str("xyzzy‽", :eol("\x0D\x0A"));
my $decoded = MIME::Base64.decode-str($encoded);
=end code

or

=begin code :lang<raku>
use MIME::Base64;

my $encoded     = MIME::Base64.encode($blob, );
my $decoded-buf = MIME::Base64.decode($encoded);
=end code

=head1 DESCRIPTION

Implements encoding and decoding to and from base64.

=head1 METHODS

=head2 encode(Blob $data, :$oneline, :$eol = "\n" --> Str:D)

Encodeѕ binary data C<$data> in base64 format.

By default, the output is wrapped every 76 characters. If `:$oneline` is set,
wrapping will be disabled.  Also optionally takes a C<:eol> named argument
to indicate the type of line-ending to be used.  Defaults to C<"\n">.

=head2 decode(Str:D $encoded --> Str:D)

Decodes base64 encoded data into a binary buffer.

=head2 encode-str(Str:D $string, :$oneline, :$eol = "\n" --> Str:D)`

Encodes C<$string> into base64, assuming utf8 encoding.  By default, the
output is wrapped every 76 characters. If `:$oneline` is set, wrapping will
be disabled.  Also optionally takes a C<:eol> named argument to indicate
the type of line-ending to be used.  Defaults to C<"\n">.

=head2 decode-str(Str:D $encoded --> Str:D)`

Decodes C<$encoded> into a string, assuming utf8 encoding.

=head1 COMPATIBILITY METHODS

=head2 encode_base64(Str:D $string --> Str:D)

Same as C<.encode-str($string>.

=head2 decode_base64(Str:D $encoded --> Str:D)

Calls C<.decode-str($encoded)>

=head1 AUTHORS

Originally written by Adrian White.  Maintained by many other people over
the years.  Now being maintained as a Raku community module.

=head1 COPYRIGHT AND LICENSE

Copyright 2010 - 2011  Adrian White

Copyright 2012 - 2025  Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
