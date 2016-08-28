#!/usr/bin/env perl

use strict;
use warnings;

use LWP::Simple qw(getstore);

use v5.16;

my $dir = shift || ".";
my $previo = shift || "IV-2015-16";

for my $d ( qw( ejercicios objetivos practicas sesiones ) ) {
  mkdir("$dir/$d");
  getstore("https://github.com/JJ/$previo/blob/master/$dir/README.md",
	   "$dir/README.md")
}

for my $f ( qw (.gitignore LICENSE Metodología_y_criterios_de_evaluación.md README.md)) {
   getstore("https://github.com/JJ/$previo/blob/master/$f",
	   $f)
}
