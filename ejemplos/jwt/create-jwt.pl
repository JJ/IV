#!/usr/bin/env perl

use strict;
use warnings;
use Crypt::JWT qw(encode_jwt);

use v5.14;

my $name = shift || "estudiante";

say encode_jwt( payload => { user => $name, sub => "IV" },
                alg => 'HS256',
                key => $ENV{'IV_SECRET'} );

