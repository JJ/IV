#!/usr/bin/env raku

my $asistencia = @*ARGS[0] // "../asistencia-2023-09-14.txt";

my @asistentes = $asistencia.IO.lines();

say @asistentes;
