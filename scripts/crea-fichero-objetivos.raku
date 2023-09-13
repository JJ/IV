#!/usr/bin/env perl6

use Text::CSV;

my $csv-name = @*ARGS[0];

my @lines = csv(in => $csv-name);
for @lines[1..*] -> $l {
    next if $l[0] !~~ /^^\w/;
    my $id = $l[1]
            ??$l[1]
            !!$l[0].split(/\s+ | \s* "," \s+/).map( *.comb.first );
    say "| <!-- Enlace de $id --> | | |"
}
