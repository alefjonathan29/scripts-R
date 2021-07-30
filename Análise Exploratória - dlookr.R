install.packages('dlookr')

#Pacote dlookr 
library(dlookr)
#Se não tiver o tidyverse instalado decomente a linha abaixo:
#install.packages('tidyverse')
library(tidyverse)

dados <- iris

#Inserir em "target=" o nome da coluna categórica (ex: a coluna 
#que está os nomes dos grupos)

#Salvando em html
dados %>%
  eda_web_report(target = "Species", subtitle = "heartfailure", 
                 output_dir = "./", output_file = "EDA.html", 
                 theme = "blue")

#Salvando em pdf
dlookr::eda_paged_report(iris, subtitle = "Iris", 
                         output_file = "EDA2.pdf",output_dir = "./",
                         theme = "blue")
