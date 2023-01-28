library(parsedate)

objetivo.decay <- function( fichero, fecha.inicio ) {
  datos <- read.csv(fichero, sep=";")
  inicio <- parse_iso_8601(fecha.inicio)
  datos$Correccion <- parse_iso_8601(datos$Correccion)
  datos$Correccion.Semana <- as.numeric( datos$Correccion - inicio, units = "weeks")
  
  datos$Entrega <- parse_iso_8601(datos$Entrega)
  datos$Entrega.Semana <- as.numeric( datos$Entrega - inicio, units = "weeks")
  
  datos$superacion <- as.numeric(datos$Correccion - datos$Entrega, units="days");
  
  return( datos )
}