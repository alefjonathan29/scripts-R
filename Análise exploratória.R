#Carregando pacote tidyverse
library(tidyverse)

#Chamando o dataset diamonds
dados <- diamonds

#Resumindo os dados e apresentando seus status
summary(dados)

#Transformando coluna em categórica
dados$cut <- as.factor(dados$cut)

#Vendo o status novamente
summary(dados)

#Gerando um barplot e contando o n de espécies
ggplot(data = dados) +
  geom_bar(mapping = aes(x = Species))

dados %>% 
  count(Species)

ggplot(data = dados, mapping = aes(x=Sepal.Length colour = Species))+
  geom_freqpoly(binwindth = 0.1)


ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)
