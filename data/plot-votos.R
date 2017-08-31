require("ggplot2")
require("ggthemes")

data <- read.csv("2017-respuestas.csv")
ggplot( data, aes(x=reorder(Respuesta,votos),y=votos,fill=votos))+ geom_bar(stat='identity') + coord_flip()
ggsave("2017-respuestas.png")
