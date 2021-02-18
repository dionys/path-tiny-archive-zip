# NAME

Path::Tiny::Archive::Zip - Zip/unzip add-on for file path utility

# VERSION

version 0.001

# DESCRIPTION

This module provides two additional methods for [Path::Tiny](https://metacpan.org/pod/Path::Tiny) for working with
zip archives.

# METHODS

## zip

    path("/tmp/foo.txt")->zip("/tmp/foo.zip");
    path("/tmp/foo")->zip("/tmp/foo.zip");

## unzip

    path("/tmp/foo.zip")->zip("/tmp/foo");

# AUTHOR

Denis Ibaev <dionys@gmail.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Denis Ibaev.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
