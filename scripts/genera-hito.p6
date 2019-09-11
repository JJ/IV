#!/usr/bin/env perl6

use v6;

say "| Nombre | Enlace | Versión |
|--------|--------|---------|";


say "|$_ | | | " for $*ARGFILES.lines;
