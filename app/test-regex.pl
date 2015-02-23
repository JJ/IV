#!/usr/bin/env perl

use File::Slurp qw(read_file);

my $file_content = read_file("../documentos/temas/Contenedores.md");

my ($breadcrumb) = ($file_content =~ /<!--@(.+)-->/gs);

print $breadcrumb;
