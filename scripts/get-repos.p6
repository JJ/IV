#!/usr/bin/env perl6

use v6;

use LWP::Simple;
use JSON::Fast;

my $token= %*ENV{'TRAVIS_TOKEN'};


my $builds-json = LWP::Simple.get("https://api.travis-ci.com/repos?limit=50",
				  { Travis_API_Version => 3,
				    user_agent => "IV-explorer-Raku",
				    authorization => "token $token" } );

say $builds-json;
