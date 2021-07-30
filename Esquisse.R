library(esquisse)

esquisser(viewer = "browser")#Abrir no Navegador 

library(dplyr)
library(ggplot2)

diamonds %>%
 filter(!(color %in% "J")) %>%
 ggplot() +
 aes(x = carat, y = x, colour = color) +
 geom_point(size = 1L) +
 scale_color_hue() +
 ggthemes::theme_few() +
 facet_wrap(vars(color))

