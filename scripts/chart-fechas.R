require(ggplot2)
require(ggthemes)
library(parsedate)

datos <- read.csv("../IV-21-22/data/fechas-entrega.csv", sep=";")

datos$Correccion <- parse_iso_8601(datos$Correccion)
datos$Entrega <- parse_iso_8601(datos$Entrega)

datos$superacion <- (datos$Correccion - datos$Entrega)/86400;

summary( datos$superacion )
datos$Objetivo <- as.factor(datos$Objetivo)
ggplot( datos, aes(x=Entrega,y=Objetivo))+geom_point()+theme_economist_white()
ggplot( datos, aes(x=Objetivo, y=superacion,color=Objetivo))+ geom_boxplot()
superados <- datos[ datos$Incompleto == "Completo",]
ggplot( superados, aes(x=Objetivo, y=superacion,color=Objetivo))+ geom_boxplot() +theme_economist_white()
ggplot( datos, aes(x=Objetivo, y=Entrega,color=Objetivo))+ geom_boxplot() +theme_economist_white()
