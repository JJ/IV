library(parsedate)
library(dplyr)

datos <- read.csv("../../IV-21-22/data/fechas-entrega.csv", sep=";")
inicio <- parse_iso_8601("2021-09-13T00:00:00+02:00")
datos$Correccion <- parse_iso_8601(datos$Correccion)
datos$Correccion.Semana <- as.numeric( datos$Correccion - inicio, units = "weeks")

datos$Entrega <- parse_iso_8601(datos$Entrega)
datos$Entrega.Semana <- as.numeric( datos$Entrega - inicio, units = "weeks")
datos$superacion <- as.numeric(datos$Correccion - datos$Entrega, units="days");
summary( datos$superacion )
summary(datos$Entrega.Semana)
datos$Objetivo <- as.factor(datos$Objetivo)
superados <- datos[ datos$Incompleto == "Completo",]
estudiantes.superado <- datos[ datos$Objetivo == 6, ]$Estudiante

solo.superados <- filter( datos, Estudiante %in% estudiantes.superado )
no.superados <- filter( datos, ! Estudiante %in% estudiantes.superado )
solo.superados$Objetivo <- paste(solo.superados$Objetivo,"S")
no.superados$Objetivo <- paste(no.superados$Objetivo,"N")

top.objetivo <- (datos %>% group_by( Estudiante ) %>% top_n(1, Objetivo ))[,c('Objetivo','Estudiante','Incompleto')]
avg.correccion <- (datos %>% group_by( Estudiante ) %>% dplyr::summarize(Mean = mean(superacion, na.rm=TRUE)))[,c('Mean','Estudiante')]
avg.entrega <- (datos %>% group_by( Estudiante ) %>% dplyr::summarize(Mean = mean(Entrega, na.rm=TRUE)))[,c('Mean','Estudiante')]

objetivo.vs.duracion <- merge(x=top.objetivo,y=avg.correccion,by.x="Estudiante")[,c('Objetivo','Mean','Incompleto')]

percentiles.correccion <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Cuartil3 = quantile(superacion,0.75,na.rm=TRUE)))

percentiles.entrega <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Entrega,0.5,na.rm=TRUE)))

percentiles.entrega.semana <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Entrega.Semana,0.5,na.rm=TRUE)))
percentiles.entrega.semana.cuartil3 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Cuartil3 = quantile(Entrega.Semana,0.75,na.rm=TRUE)))
percentiles.entrega.semana.decil9 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Decil9 = quantile(Entrega.Semana,0.9,na.rm=TRUE)))
percentiles.entrega.semana.decil1 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Decil1 = quantile(Entrega.Semana,0.1,na.rm=TRUE)))

entregas.semanas <- data.frame( objetivo=c(0:9), mediana = percentiles.entrega.semana$Mediana, cuartil3 = percentiles.entrega.semana.cuartil3$Cuartil3, decil9 = percentiles.entrega.semana.decil9$Decil9, decil1 = percentiles.entrega.semana.decil1$Decil1)

percentiles.superacion.semana <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Correccion.Semana,0.5,na.rm=TRUE)))

percentiles.entrega.semana$Mediana.Dias <- round(percentiles.entrega.semana$Mediana * 7)
percentiles.entrega.semana$diferencia <-c(NA,diff( percentiles.entrega.semana$Mediana.Dias))

percentiles.entrega.semana.trescuartos <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Cuartil3 = quantile(Entrega.Semana,0.75,na.rm=TRUE)))
percentiles.entrega.semana.trescuartos$Dias <- round(percentiles.entrega.semana.trescuartos$Cuartil3 * 7)
percentiles.entrega.semana.trescuartos$diferencia <-c(NA,diff( percentiles.entrega.semana.trescuartos$Dias))

percentiles.entrega.semana.90 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Entrega.Semana,0.9,na.rm=TRUE)))
percentiles.entrega.semana.90$Dias <- round(percentiles.entrega.semana.90$Mediana * 7)
percentiles.entrega.semana.90$diferencia <-c(NA,diff( percentiles.entrega.semana.90$Dias))

percentiles.entrega.semana.10 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Entrega.Semana,0.1,na.rm=TRUE)))
percentiles.entrega.semana.10$Dias <- round(percentiles.entrega.semana.10$Mediana * 7)
percentiles.entrega.semana.10$diferencia <-c(NA,diff( percentiles.entrega.semana.10$Dias))
