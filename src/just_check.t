#!/usr/bin/env perl

use strict;
use warnings;

use Test::Text;
just_check( 'documentos/temas','.', 'Spanish', 0 );just_check( 'documentos/proyecto','.', 'Spanish',1 );