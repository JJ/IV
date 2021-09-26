#!/usr/bin/env perl6

use Text::CSV;

my $csv-name = @*ARGS[0];

my @lines = csv(in => $csv-name);
for @lines[1..*] -> $l {
    my $id = $l[2]
            ??$l[2]
            !!$l[0].split(/\s+|","\s+/).map( *.comb.first );
    say "| <!-- Enlace de $id --> | | |"
}
