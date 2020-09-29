require(ggplot2)
require(ggthemes)

data <- read.csv("uso-git.csv")
ggplot(data,aes(x=Año,y=Conocimiento))+geom_line()+theme_economist()
