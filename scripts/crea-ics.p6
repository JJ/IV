#!/usr/bin/env raku

my ($fecha,$objetivo,$percentil) = @*ARGS;

my ($dia,$mes) = $fecha.split("/");
my $date = Date.new( 2022, $mes, $dia );

my $ics = q:to<EOI>;
 BEGIN:VCALENDAR
 VERSION:2.0
 CALSCALE:GREGORIAN
 BEGIN:VEVENT
 SUMMARY:Recordatorio objetivo $objetivo
 DTSTART;TZID=Europe/Madrid:$date
 DTEND;TZID=Europe/Madrid:$date
 DESCRIPTION: Objetivo $objetivo: $percentil lo ha entregado en esta fecha
 STATUS:CONFIRMED

 BEGIN:VALARM
 TRIGGER:-PT12H
 DESCRIPTION:Recordatorio objetivo
 ACTION:DISPLAY
 END:VALARM
 END:VEVENT
 END:VCALENDAR
EOI

spurt( $objetivo ~ "-" ~ $percentil.split(" ").join("-") ~ ".ics", $ics);
