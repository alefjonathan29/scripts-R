if(!require(rstatix)) install.packages("rstatix") # Instala??o do pacote caso n?o esteja instalado
library(rstatix)  #Para o Post-hoc do Kurskal Wallis

dados <- iris
#Ver o estilo da tabela
View(dados)

#Normalidade de toda tabela
lshap <- lapply(dados[,-5 ], shapiro.test)
lshap
unlist(lapply(lshap, function(x) x$p.value))

#homocedasticidade (Eu não consegui fazer para toda tabela de uma vez)
bartlett.test(Sepal.Length ~Species, data = dados)
bartlett.test(Sepal.Width~Species, data = dados)
bartlett.test(Petal.Length~Species, data = dados)
bartlett.test(Petal.Width ~Species, data = dados)

#Kruskal Wallis (Fazer por variável x grupo, um de cada vez)
kruskal.test(Sepal.Length~Species, data = dados)
kruskal.test(Sepal.Width~Species, data = dados)
kruskal.test(Petal.Length~Species, data = dados)
kruskal.test(Petal.Width~Species, data = dados)

#Post-hoc Dunn-Bonferroni (Fazer por variável x grupo, um de cada vez)
dunn_test(Petal.Length~Species, data = dados, p.adjust.method = "bonferroni")
dunn_test(Sepal.Width~Species, data = dados, p.adjust.method = "bonferroni")
dunn_test(Petal.Length~Species, data = dados, p.adjust.method = "bonferroni")
dunn_test(Petal.Width~Species, data = dados, p.adjust.method = "bonferroni")


