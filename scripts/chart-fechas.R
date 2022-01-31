require(ggplot2)
require(ggthemes)
library(parsedate)
library(dplyr)

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

estudiantes.superado <- datos[ datos$Objetivo == 6, ]$Estudiante

solo.superados <- filter( datos, Estudiante %in% estudiantes.superado )
no.superados <- filter( datos, ! Estudiante %in% estudiantes.superado )

ggplot( solo.superados, aes(x=Objetivo, y=Entrega,color=Objetivo))+ geom_boxplot() +theme_economist_white()


ggplot()+ geom_boxplot(data=no.superados, aes(x=Objetivo, y=superacion,color=Objetivo),width=0.5,notch=TRUE)+geom_boxplot(data=solo.superados, aes(x=Objetivo, y=superacion,color=Objetivo,fill=Objetivo),width=0.5,notch=TRUE) +theme_economist_white()
