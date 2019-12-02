library(ggplot2)
library(dplyr)
library(ggthemes)
data <- read.csv("notas-suspensos-entregas-2015-2019.csv")


data <- data %>% group_by(Curso) %>% mutate(Porcentaje = Cuantos/max(Cuantos))
data$Curso <- as.factor(data$Curso)
ggplot( data,aes(x=Hito,y=Porcentaje,color=Curso,group=Curso)) + geom_line() + theme_solarized()
