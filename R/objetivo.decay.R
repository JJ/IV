objetivo.decay <- function( fichero, fecha.inicio ) {
  datos <- read.csv(fichero, sep=";")
  inicio <- parse_iso_8601(fecha.inicio)
}