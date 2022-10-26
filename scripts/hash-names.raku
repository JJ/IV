#!/usr/bin/env perl6

use Digest::MD5;

my @lines = "../IV-21-22/data/fechas-entrega.csv".IO.lines;

say @lines.shift;

my $md5 = Digest::MD5.new();
for @lines -> $l {
    my ($objetivo,$name, @rest ) = $l.split(";");
    say [ $objetivo, $md5.md5_hex($name), |@rest ].join(";");
}
