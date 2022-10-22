library(parsedate)
library(dplyr)
library(ggplot2)
library(ggthemes)
datos <- read.csv("../IV-21-22/data/fechas-entrega.csv", sep=";")

inicio <- parse_iso_8601("2021-09-13T00:00:00+02:00")

datos$Correccion <- parse_iso_8601(datos$Correccion)
datos$Correccion.Semana <- as.numeric( datos$Correccion - inicio, units = "weeks")

datos$Entrega <- parse_iso_8601(datos$Entrega)
datos$Entrega.Semana <- as.numeric( datos$Entrega - inicio, units = "weeks")

datos$superacion <- as.numeric(datos$Correccion - datos$Entrega, units="days");
estudiantes.superado <- datos[ datos$Objetivo == 5, ]$Estudiante

datos$aprobado <- datos$Estudiante %in% estudiantes.superado

datos.obj.3 <- subset(datos[ datos$Objetivo == 3,],select = c(Entrega.Semana,Correccion.Semana,superacion,aprobado))
logit.entrega.3 <- glm( aprobado ~ Entrega.Semana, family="binomial", data=datos.obj.3)
summary(logit.entrega.3)

probabilidades <- data.frame(semana=numeric(),probabilidad=numeric())
for (i in 7:15 ) {
  eta = predict( logit.entrega.3, data.frame(Entrega.Semana=i))
  probabilidades <- rbind(probabilidades, data.frame(semana=i, probabilidades=exp(eta)/(1+exp(eta))))
}

ggplot(probabilidades,aes(x=semana,y=probabilidades))+geom_point()+geom_line()+theme_economist()+ylim(0,1)
datos.obj.4 <- subset(datos[ datos$Objetivo == 4,],select = c(Entrega.Semana,Correccion.Semana,superacion,aprobado))
logit.entrega.4 <- glm( aprobado ~ Entrega.Semana, family="binomial", data=datos.obj.4)
summary(logit.entrega.4)
