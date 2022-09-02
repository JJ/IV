require(ggplot2)
require(ggthemes)
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
ggplot( datos, aes(x=Entrega,y=Objetivo))+geom_point()+theme_economist_white()
ggplot( datos, aes(x=Objetivo, y=superacion,color=Objetivo))+ geom_boxplot()
superados <- datos[ datos$Incompleto == "Completo",]
ggplot( superados, aes(x=Objetivo, y=superacion,color=Objetivo))+ geom_boxplot() +theme_economist_white()
ggplot( datos, aes(x=Objetivo, y=Entrega,color=Objetivo))+ geom_boxplot() +theme_economist_white()
ggplot( superados, aes(x=Objetivo, y=Entrega,color=Objetivo))+ geom_boxplot() +theme_economist_white()

estudiantes.superado <- datos[ datos$Objetivo == 6, ]$Estudiante

solo.superados <- filter( datos, Estudiante %in% estudiantes.superado )
no.superados <- filter( datos, ! Estudiante %in% estudiantes.superado )
solo.superados$Objetivo <- paste(solo.superados$Objetivo,"S")
no.superados$Objetivo <- paste(no.superados$Objetivo,"N")
ggplot( solo.superados, aes(x=Objetivo, y=Entrega,color=Objetivo))+ geom_boxplot() +theme_economist_white()


ggplot()+ geom_boxplot(data=no.superados, aes(x=Objetivo, y=superacion,color=Objetivo),width=0.5,notch=TRUE)+geom_boxplot(data=solo.superados, aes(x=Objetivo, y=superacion,color=Objetivo,fill=Objetivo),width=0.5,notch=TRUE) +theme_economist_white()

top.objetivo <- (datos %>% group_by( Estudiante ) %>% top_n(1, Objetivo ))[,c('Objetivo','Estudiante','Incompleto')]
avg.correccion <- (datos %>% group_by( Estudiante ) %>% dplyr::summarize(Mean = mean(superacion, na.rm=TRUE)))[,c('Mean','Estudiante')]
avg.entrega <- (datos %>% group_by( Estudiante ) %>% dplyr::summarize(Mean = mean(Entrega, na.rm=TRUE)))[,c('Mean','Estudiante')]

objetivo.vs.duracion <- merge(x=top.objetivo,y=avg.correccion,by.x="Estudiante")[,c('Objetivo','Mean','Incompleto')]
ggplot(objetivo.vs.duracion, aes(x=Objetivo,y=Mean,color=Incompleto) )+ geom_point()+theme_economist_white()

percentiles.correccion <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Cuartil3 = quantile(superacion,0.75,na.rm=TRUE)))

percentiles.entrega <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Entrega,0.5,na.rm=TRUE)))

percentiles.entrega.semana <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Entrega.Semana,0.5,na.rm=TRUE)))
percentiles.entrega.semana.cuartil3 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Cuartil3 = quantile(Entrega.Semana,0.75,na.rm=TRUE)))
percentiles.entrega.semana.decil9 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Decil9 = quantile(Entrega.Semana,0.9,na.rm=TRUE)))


entregas.semanas <- data.frame( objetivo=c(0:9), mediana = percentiles.entrega.semana$Mediana, cuartil3 = percentiles.entrega.semana.cuartil3$Cuartil3, decil9 = percentiles.entrega.semana.decil9$Decil9)

ggplot()+geom_point(data=entregas.semanas, aes(x=mediana,y=objetivo))+geom_point(data=entregas.semanas, aes(x=cuartil3,y=objetivo,color="3 cuartil"))+geom_point(data=entregas.semanas, aes(x=decil9,y=objetivo,color="90%"))+ scale_x_continuous(breaks=c(0:16),labels=c(1:17))+ scale_y_continuous(breaks=c(0:9),labels=c(0:9))+
  theme(axis.text.x = element_text(face="bold", color="#993333", size=14, angle=45))

percentiles.superacion.semana <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Correccion.Semana,0.5,na.rm=TRUE)))
percentiles.entrega.semana$Mediana.Dias <- round(percentiles.entrega.semana$Mediana * 7)
percentiles.entrega.semana$diferencia <-c(NA,diff( percentiles.entrega.semana$Mediana.Dias))

percentiles.entrega.semana.trescuartos <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Cuartil3 = quantile(Entrega.Semana,0.75,na.rm=TRUE)))
percentiles.entrega.semana.trescuartos$Dias <- round(percentiles.entrega.semana.trescuartos$Mediana * 7)
percentiles.entrega.semana.trescuartos$diferencia <-c(NA,diff( percentiles.entrega.semana.trescuartos$Dias))

percentiles.entrega.semana.90 <- (superados %>% group_by( Objetivo ) %>% dplyr::summarize(Mediana = quantile(Entrega.Semana,0.9,na.rm=TRUE)))
percentiles.entrega.semana.90$Dias <- round(percentiles.entrega.semana.90$Mediana * 7)
percentiles.entrega.semana.90$diferencia <-c(NA,diff( percentiles.entrega.semana.90$Dias))
