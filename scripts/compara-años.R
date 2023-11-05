library(parsedate)
library(dplyr)
library(ggplot2)

datos <- read.csv("../IV-21-22/data/fechas-entrega.csv", sep=";")

inicio <- parse_iso_8601("2021-09-13T00:00:00+02:00")

datos$Correccion <- parse_iso_8601(datos$Correccion)
datos$Correccion.Semana <- as.numeric( datos$Correccion - inicio, units = "weeks")

datos$Entrega <- parse_iso_8601(datos$Entrega)
datos$Entrega.Semana <- as.numeric( datos$Entrega - inicio, units = "weeks")

datos$superacion <- as.numeric(datos$Correccion - datos$Entrega, units="days");
datos$curso = "21-22"
datos <- datos[order(datos$Entrega),]
datos$entregas <- seq.int(nrow(datos))

datos.2223 <- read.csv("../IV-22-23/data/fechas-entrega.csv", sep=";")

inicio.2223 <- parse_iso_8601("2022-09-13T00:00:00+02:00")

datos.2223$Correccion <- parse_iso_8601(datos.2223$Correccion)
datos.2223$Correccion.Semana <- as.numeric( datos.2223$Correccion - inicio.2223, units = "weeks")

datos.2223$Entrega <- parse_iso_8601(datos.2223$Entrega)
datos.2223$Entrega.Semana <- as.numeric( datos.2223$Entrega - inicio.2223, units = "weeks")

datos.2223$superacion <- as.numeric(datos.2223$Correccion - datos.2223$Entrega, units="days");
datos.2223$curso = "22-23"
datos.2223 <- datos.2223[order(datos.2223$Entrega),]
datos.2223$entregas <- seq.int(nrow(datos.2223))

# 2324
datos.2324 <- read.csv("../IV-/data/fechas-entrega.csv", sep=";")

inicio.2324 <- parse_iso_8601("2023-09-13T00:00:00+02:00")

datos.2324$Correccion <- parse_iso_8601(datos.2324$Correccion)
datos.2324$Correccion.Semana <- as.numeric( datos.2324$Correccion - inicio.2324, units = "weeks")

datos.2324$Entrega <- parse_iso_8601(datos.2324$Entrega)
datos.2324$Entrega.Semana <- as.numeric( datos.2324$Entrega - inicio.2324, units = "weeks")

datos.2324$superacion <- as.numeric(datos.2324$Correccion - datos.2324$Entrega, units="days");
datos.2324$curso = "23-24"
datos.2324 <- datos.2324[order(datos.2324$Entrega),]
datos.2324$entregas <- seq.int(nrow(datos.2324))


today <- Sys.time()

days <- today - inicio.2324

date.2122 <- inicio + days
date.2223 <- inicio.2223 + days

hasta.hoy.2122 <- datos[ datos$Entrega <= date.2122, ]
hasta.hoy.2223 <- datos.2223[ datos.2223$Entrega <= date.2223, ]

compara.cursos <- rbind( hasta.hoy.2223, hasta.hoy.2122)
compara.cursos <- rbind( compara.cursos, datos.2324)

ggplot(compara.cursos, aes(x=Entrega.Semana, y=entregas, color=curso)) + geom_line() + geom_point(colour=1+compara.cursos$Objetivo)

print(mean(hasta.hoy.2122$Objetivo))
print(mean(datos.2223$Objetivo))

correcciones.2223 <- datos.2223[!is.na(datos.2223$Correccion),]
correcciones.2223 <- correcciones.2223[order(correcciones.2223$Correccion),]
correcciones.2223$entregas <- seq.int(nrow(correcciones.2223))

correcciones.hasta.hoy.2122 <- hasta.hoy.2122[ hasta.hoy.2122$Correccion <= date.2122, ]

correcciones.hasta.hoy.2122 <- correcciones.hasta.hoy.2122[ correcciones.hasta.hoy.2122$Incompleto == "Completo",]
correcciones.hasta.hoy.2122 <- correcciones.hasta.hoy.2122[order(correcciones.hasta.hoy.2122$Correccion),]
correcciones.hasta.hoy.2122$entregas <- seq.int(nrow(correcciones.hasta.hoy.2122))
correcciones.vs.22.23 <- rbind( correcciones.2223, correcciones.hasta.hoy.2122)

ggplot(correcciones.vs.22.23, aes(x=Correccion.Semana, y=entregas, color=curso)) + geom_line() + geom_point(colour=1+correcciones.vs.22.23$Objetivo)

ggplot(correcciones.vs.22.23, aes(x=curso,y=superacion))+ geom_boxplot( notch=T)
summary(correcciones.2223$superacion)
summary(correcciones.hasta.hoy.2122$superacion)
wilcox.test(correcciones.2223$superacion,correcciones.hasta.hoy.2122$superacion)

