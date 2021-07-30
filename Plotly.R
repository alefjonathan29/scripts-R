dados <- mtcars

library(ggplot2)
library(plotly)

p <- ggplot(dados) +
 aes(x = cyl, y = mpg) +
 geom_boxplot(fill = "#0c4c8a") +
 theme_bw()
ggplotly(p)
