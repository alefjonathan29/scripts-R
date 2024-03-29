#Perfect Scatter Plots with Correlation and Marginal Histograms
#http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/78-perfect-scatter-plots-with-correlation-and-marginal-histograms/?fbclid=IwAR2dXkZR1dFWP8ZEZpsaNOtTXlHPRwRgaGRLSIRVIfhi1Eq7P1XBbLRRO10


#install.packages('cowplot')
#install.packages('ggpubr')

library(ggplot2)
library(cowplot) 

# Main plot
pmain <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species))+
  geom_point()+
  ggpubr::color_palette("jco")
# Marginal densities along x axis
xdens <- axis_canvas(pmain, axis = "x")+
  geom_density(data = iris, aes(x = Sepal.Length, fill = Species),
               alpha = 0.7, size = 0.2)+
  ggpubr::fill_palette("jco")
# Marginal densities along y axis
# Need to set coord_flip = TRUE, if you plan to use coord_flip()

ydens <- axis_canvas(pmain, axis = "y", coord_flip = TRUE)+
        geom_density(data = iris, aes(x = Sepal.Width, fill = Species),
               alpha = 0.7, size = 0.2)+
        coord_flip()+
        ggpubr::fill_palette("jco")


p1 <- insert_xaxis_grob(pmain, xdens, grid::unit(.2, "null"), position = "top")
p2<- insert_yaxis_grob(p1, ydens, grid::unit(.2, "null"), position = "right")
ggdraw(p1)
