devtools::install_github("abjur/abjData")
library(abjData)
library(dplyr)
dados <- pnud_min
dados %>% 
  group_by(regiao, uf)

dados%>%group_by(regiao)%>%
  summarise(espvida = mean(espvida))
