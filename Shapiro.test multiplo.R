library(rstatix)  #Para o Post-hoc do Kurskal Wallis

dados <- iris
#Ver o estilo da tabela
View(dados)

#Normalidade de toda tabela
lshap <- lapply(dados[,-5 ], shapiro.test)
lshap
unlist(lapply(lshap, function(x) x$p.value))