#!/usr/bin/env perl

use strict;
use warnings;
use File::Slurper qw(read_lines);

use v5.14;

my $file_name = shift || "hito-0.md";

my @lines = read_lines($file_name);

die "No va el fichero" if !@lines;

for my $l (@lines) {
  if ( $l !~ /\|/ ) {
    say $l;
  } else {
    if ( $l =~ /Nombre/) {
      say $l;
    } elsif ( $l =~ /----/ ) {
      say $l;
    } else {
      my ($zipi,$nombre,@zape) = split(/\|/, $l);
      say "|$nombre|", " |" x @zape ;
    }
  }
}
