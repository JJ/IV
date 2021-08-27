#!/usr/bin/env perl

use strict;
use warnings;

use File::Copy; # Recuerda cpanm --installdeps .
use File::Path qw(make_path);
use Cwd;

use v5.16;

my $dir = shift || ".";
my $previo = shift || "IV-20-21";

for my $d ( qw( proyectos sesiones) ) {
    eval {
	mkdir("$dir/$d");
    };

    my $url = "http://raw.githubusercontent.com/JJ/$previo/master/$d/README.md";
    `wget --backups=1  $url`;
    move( 'README.md', "$dir/$d/" ) || die "Can't write file";
}

download_files_here( qw (.gitignore LICENSE Metodología_y_criterios_de_evaluación.md README.md cpanfile) );

create_and_download("t", "check-hitos.t");

create_and_download( ".github/workflows", qw( check-by-milestone.yaml   ficheros.yml  objetivos.yml check-usuario-objetivos.yaml  get-pr-checks.yml  procesa_yaml.sh) );

create_and_download( "src", "get-config.pl" );

sub download_files_here {
  for my $f (  @_ ) {
    `wget  --backups=1 https://raw.githubusercontent.com/JJ/$previo/master/$f`;
  }
}

sub download_files {
  my $dir = shift;
  for my $f (  @_ ) {
    `wget  --backups=1 https://raw.githubusercontent.com/JJ/$previo/master/$dir/$f`;
  }
}

sub create_and_download {
  my $dir = shift;
  my $former_dir = getcwd;
  make_path( $dir );
  chdir( $dir );
  download_files( $dir, @_ );
  chdir( $former_dir );
}
