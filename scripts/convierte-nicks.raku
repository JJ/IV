#!/usr/bin/env perl6

# Convierte nicks desde Telegram a Github

use Text::CSV;

my $fichero-equivalencias = @*ARGS[0];
my $fichero-nicks = @*ARGS[1];

my @lines = csv(in => $fichero-equivalencias);
my %nick-github-de;
for @lines[1..*] -> $l {
    next if $l[0] !~~ /^^\w/;
    next if !$l[1];
    %nick-github-de{lc($l[2])} = lc($l[1]);
}

my @asistentes = $fichero-nicks.IO.lines();
say @asistentes;

say @asistentes.map( { %nick-github-de{lc($_)} }).join("\n");
