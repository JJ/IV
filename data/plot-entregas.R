library(ggplot2)
library(dplyr)
library(ggthemes)
data <- read.csv("notas-suspensos-entregas-2015-2019.csv")


data$Curso <- as.factor(data$Curso)
data[is.na(data)] <- 0
data$Aprobados <- data$Cuantos - data$Suspensos
data <- data %>% group_by(Curso) %>% mutate(Porcentaje = Aprobados/max(Cuantos))
ggplot( data,aes(x=Hito,y=Porcentaje,color=Curso,group=Curso)) + geom_line() + geom_point() + theme_solarized()

