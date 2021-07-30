dados <- read.csv("densidadeteste.csv", header = T, sep = ";")
calculo <- (((dados[,6:39]*dados$dilui)/2)/dados$vol)
sum.calculo <- data.frame(summary(calculo))
summar

library(dplyr)
library(tidyverse)
summarise(calculo)

soma <- sum(calculo[1:54,])
soma <- data.frame(rowSums(calculo[,1:34]))
total <- sum(soma)
ab.relativa <- (soma/total)*100
sum(ab.relativa)
df <- rbind(calculo, ab.relativa)
invert <- (ab.relativa,~)

DADOS = calculo %>%
   mutate(sum(1:54,1:34))

