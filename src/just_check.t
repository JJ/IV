#!/usr/bin/env perl

use strict;
use warnings;

use Test::Text;
just_check( 'documentos/temas','.', 'Spanish', 0 ); # Don't do done_testing
just_check( 'documentos/proyecto','.', 'Spanish',1  ); # Do it 
