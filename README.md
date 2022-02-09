[![Actions Status](https://github.com/raku-community-modules/MIME-Base64/workflows/test/badge.svg)](https://github.com/raku-community-modules/MIME-Base64/actions)

NAME
====

MIME::Base64 - Encoding and decoding Base64 ASCII strings

SYNOPSIS
========

```raku
use MIME::Base64;

my $encoded = MIME::Base64.encode-str("xyzzy‽");
my $decoded = MIME::Base64.decode-str($encoded);
```

or

```raku
use MIME::Base64;

my $encoded     = MIME::Base64.encode($blob);
my $decoded-buf = MIME::Base64.decode($encoded);
```

DESCRIPTION
===========

Implements encoding and decoding to and from base64.

METHODS
=======

encode(Blob $data, :$oneline --> Str:D)
---------------------------------------

Encodeѕ binary data `$data` in base64 format.

By default, the output is wrapped every 76 characters. If `:$oneline` is set, wrapping will be disabled.

decode(Str:D $encoded --> Str:D)
--------------------------------

Decodes base64 encoded data into a binary buffer.

encode-str(Str:D $string, :$oneline --> Str:D)`
-----------------------------------------------

Encodes `$string` into base64, assuming utf8 encoding.

decode-str(Str:D $encoded --> Str:D)`
-------------------------------------

Decodes `$encoded` into a string, assuming utf8 encoding.

COMPATIBILITY METHODS
=====================

encode_base64(Str:D $string --> Str:D)
--------------------------------------

Same as `.encode-str($string`.

decode_base64(Str:D $encoded --> Str:D)
---------------------------------------

Calls `.decode-str($encoded)`

AUTHOR
======

Originally written by Adrian White. Maintained by many other people over the years. Now being maintained as a Raku community module.

COPYRIGHT AND LICENSE
=====================

Copyright 2010 - 2011 Adrian White

Copyright 2012 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

