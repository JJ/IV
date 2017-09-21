#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;

use File::Slurp::Tiny qw(read_lines);

my $file_name = shift || "2017.csv";

my @lines = read_lines($file_name);

shift @lines;
my %respuestas;

for my $l (@lines) {
  chop $l;
  my @respuestas = split(/, /, $l);
  for my $r (@respuestas) {
    $respuestas{$r}++;
  }
}
say "Respuesta, votos";
for my $k ( sort { $respuestas{$b} <=> $respuestas{$a} } keys %respuestas ) {
  say "$k, $respuestas{$k}";
}
