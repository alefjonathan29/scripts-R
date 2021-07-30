install.packages("googleVis")
library(googleVis)
library(tidyverse)



###criando o dataframe, mas aqui tu vai chamar tua tabela
dat <- data.frame(From=c(rep("A",3), rep("B", 3)), 
                  To=c(rep(c("X", "Y", "Z"),2)), 
                  Weight=c(5,7,6,2,9,4))

###Diagrama Simples, substitui as variáveis
sk1 <- gvisSankey(dat, from="From", to="To", weight="Weight")
plot(sk1)

###Diagrama com cor nos links entre os grupos
sk2 <- gvisSankey(dat, from="From", to="To", weight="Weight",
                  options=list(sankey="{link: {colorMode: 'source' },
                                        node: { color: { fill: '#a61d4c' },
                                                label: { color: '#871b47' } }}"))
plot(sk2)


library(dplyr)
mini_iris <-
  iris %>%
  group_by(Species) %>%
  slice(1)
dados <- mini_iris %>% gather(key = "flower_att", value = "measurement", -Species)
summary(dados)
sk2 <- gvisSankey(dados, from="Species", to="flower_att", weight="measurement",
                  options=list(sankey="{link: {colorMode: 'source' },
                                        node: { color: { fill: '#a61d4c' },
                                                label: { color: '#871b47' } }}"))
plot(sk2)

