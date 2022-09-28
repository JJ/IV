#!/usr/bin/env raku

my ($fecha,$objetivo,$percentil) = @*ARGS;

my ($dia,$mes) = $fecha.split("/");
my $date = "2022" ~ $mes ~ $dia ~ "T235959";
my $now = DateTime.now( formatter => {
    sprintf "%04d%02d%02dT%02d%02d%02d", .year, .month, .day, .hour,
            .minute, .second;
});

my $ics = qq:to<EOI>;
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
PRODID:IV Cal
BEGIN:VEVENT
UID:$now
DTSTAMP:$now
SUMMARY:Recordatorio objetivo $objetivo
DTSTART:$date
DTEND:$date
DESCRIPTION: Objetivo $objetivo → $percentil lo ha entregado en esta fecha
STATUS:CONFIRMED
BEGIN:VALARM
TRIGGER:-PT12H
DESCRIPTION:Recordatorio objetivo
ACTION:DISPLAY
END:VALARM
END:VEVENT
END:VCALENDAR
EOI

spurt( "calendarios/" ~ $objetivo ~ "-" ~ $percentil.split(" ").join("-") ~ ".ics", $ics);

# Generate global ics file with all events of ics files inside "calendarios" folder

$ics = qq:to<EOI>;
BEGIN:VCALENDAR
VERSION:2.0
CALSCALE:GREGORIAN
PRODID:IV Cal
EOI

for dir "calendarios/" -> $file {
    if ($file.IO.path ne "calendarios/global-asignatura.ics") {
        say $file.IO.path;

        my $i = 0;
        for $file.IO.lines -> $line {
            $i++;
            if $i>=5 && $line ne "END:VCALENDAR" {
                $ics ~= "\n$line";
            }
        }
    }
}
$ics ~= "\nEND:VCALENDAR";

spurt( "calendarios/global-asignatura.ics", $ics);
