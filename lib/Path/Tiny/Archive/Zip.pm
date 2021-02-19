package Path::Tiny::Archive::Zip;

# ABSTRACT: Zip/unzip add-on for file path utility

use strict;
use warnings;

use Archive::Zip qw( :ERROR_CODES );
use Path::Tiny qw( path );


our $VERSION = '0.002';


BEGIN {
    push(@Path::Tiny::ISA, __PACKAGE__);
}

=method zip

    path("/tmp/foo.txt")->zip("/tmp/foo.zip");
    path("/tmp/foo")->zip("/tmp/foo.zip");

Creates a zip archive and appends a file or directory tree to it. Returns the
path to the zip archive or undef.

=cut

sub zip {
    my ($self, $dest) = @_;

    my $zip = Archive::Zip->new;

    if ($self->is_file) {
        $zip->addFile($self->realpath->stringify(), $self->basename);
    }
    elsif ($self->is_dir) {
        $zip->addTree($self->realpath->stringify(), '');
    }
    else {
        return;
    }

    $dest = path($dest);

    unless ($zip->writeToFileNamed($dest->realpath->stringify()) == AZ_OK) {
        return;
    }

    return $dest;
}

=method unzip

    path("/tmp/foo.zip")->unzip("/tmp/foo");

Extracts a zip archive to specified directory. Returns the path to the
destination directory or undef.

=cut

sub unzip {
    my ($self, $dest) = @_;

    my $zip = Archive::Zip->new();

    unless ($zip->read($self->realpath->stringify()) == AZ_OK) {
        return;
    }

    $dest = path($dest);
    if ($dest->exists) {
        return unless $dest->is_dir;
    }
    else {
        $dest->mkpath() or return;
    }

    unless ($zip->extractTree(undef, $dest->realpath->stringify()) == AZ_OK) {
        return;
    }

    return $dest;
}


1;


=head1 DESCRIPTION

This module provides two additional methods for L<Path::Tiny> for working with
zip archives.

=cut
