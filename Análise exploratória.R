library(tidyverse)

dados <- iris

summary(dados)

dados$Species <- as.factor(dados$Species)
summary(dados)
