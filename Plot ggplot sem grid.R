library(ggplot2)
p <- ggplot(mtcars, aes(mpg, wt, shape = factor(cyl)))
p <- p + geom_point(aes(colour = factor(cyl)), size = 4) +
  geom_point(colour = "grey90", size = 1.5)+theme_bw()


p+theme_bw()+theme(  # remove axis ticks
        axis.title.x = element_text(size=18), # remove x-axis labels
        axis.title.y = element_text(size=18), # remove y-axis labels
        panel.background = element_blank(), 
        panel.grid.major = element_blank(),  #remove major-grid labels
        panel.grid.minor = element_blank())+
  scale_y_discrete()


library(ggplot2)

ggplot(diamonds) +
 aes(x = cut, weight = carat) +
 geom_bar(fill = "#0c4c8a") +
  theme_bw()+theme(  # remove axis ticks
    axis.title.x = element_text(size=18), # remove x-axis labels
    axis.title.y = element_text(size=18), # remove y-axis labels
    legend.title = element_text(size=14),
    panel.background = element_blank(), 
    panel.grid.major = element_blank(),  #remove major-grid labels
    panel.grid.minor = element_blank())+
  labs(x = "Eixo x", y = "Eixo y", color = "Legenda")
  scale_y_continuous(expand = c(0,0)) #Remover o espaço do eixo Y, do zero para as categorias 
