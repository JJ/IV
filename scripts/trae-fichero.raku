#!/usr/bin/env raku

use WWW;

my $hito_file = @*ARGS[0] // die "Necesito el fichero con los hitos";
my $fichero = @*ARGS[1] // die "Necesito el path al fichero a buscar";
my $output-dir = @*ARGS[2] // "dir$fichero";

mkdir $output-dir unless $output-dir.IO ~~ :d;

my $hito = $hito_file.IO.slurp;

my @urls = ( $hito ~~ m:g{ ("https://github.com/" \w+ "/" \w+ ) } );

my %ficheros;
for @urls -> $url {
    $url ~~ m{ ".com/" $<usuario> = (\w+) "/" $<repo> = (\w+)  };
    for <master main> -> $master {
        my $raw_url = "https://raw.githubusercontent.com/$<usuario>/$<repo>/$master/$fichero";
        say "Intentando $raw_url";
        try {
            %ficheros{$<usuario>} = get $raw_url;
        }
        warn "No pude descargar $raw_url" if $!;
    }
}

for %ficheros.keys -> $u {
    spurt( "$output-dir/$u$fichero", %ficheros{$u} );
}

