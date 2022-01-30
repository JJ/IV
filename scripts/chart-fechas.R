require(ggplot2)
require(ggthemes)
library(parsedate)

datos <- read.csv("../IV-21-22/data/fechas-entrega.csv", sep=";")

datos$Correccion <- parse_iso_8601(datos$Correccion)
datos$Entrega <- parse_iso_8601(datos$Entrega)

datos$superacion <- datos$Correccion - datos$Entrega;

summary( datos$superacion )