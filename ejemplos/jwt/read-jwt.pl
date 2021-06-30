#!/usr/bin/env perl

use Crypt::JWT(decode_jwt);
use strict;
use warnings;

use v5.14;

while ( my $line = <> ) {
  say %{decode_jwt( token => $line, key => $ENV{'IV_SECRET'} )};
}
