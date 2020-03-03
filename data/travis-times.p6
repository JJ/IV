#!/usr/bin/env perl6

use v6;

use LWP::Simple;

my $token= %*ENV{'TRAVIS_TOKEN'};
my $repo = $*ARGS[0] // "JJ/IV-19-20";

my $builds-json = LWP::Simple.get("https://api.travis-ci.com/builds"
