library(esquisse)
library(ggplot2)
library(dplyr)
library(rvg)
library(officer)
library(ggThemeAssist)

# Set option for browser
options("esquisse.display.mode" = "browser")
options("esquisse.display.mode" = "dialog")

abundancia <- read.csv("correlacao.csv", row.names = 1, sep = ";", header = T)

esquisse::esquisser(data = iris)

iris <- ggplot(data = iris) +
  aes(x = Sepal.Length, y = Sepal.Width, fill = Species, color = Species, size = Petal.Length) +
  geom_point() +
  geom_smooth(span = 0.75) +
  labs(x = "Tamanho da Sepala ",
    y = "Largura da Sepala") +
  theme_bw() +
  facet_wrap(vars(Species))


graphic <- ggplot(data = dados) +
  aes(x = Estação, y = Perc.carc.nau, fill = Fluxo) +
  geom_boxplot() +
  theme_bw() +
  facet_wrap(vars(Fluxo))

graphic

graphic + theme(axis.title = element_text(colour = "blue2")) +
  labs(x = "Áreas de Estudo", y = "Percentual de Carcaças")
