library(vegan)

#########Ler os arquivos#####
Zoo <- read.csv("grupos_funcionais_chuvoso.csv", row.names = 1, header = T, sep = ";")
Ambiental<- read.csv("ambiental.csv", row.names = 1, header = T, sep = ";")

######## Matriz de dissimilaridade para a PERMANOVA####
Dist.spp <- vegdist(Zoo, method = 'bray')
Dist.spp

######## Rodar a PERMANOVA #####
pmv <- adonis(Dist.spp~Estado_trofico, data = Ambiental, 
                     permutations = 9999, method = 'bray')
pmv

####### Testar a Dispers?o com o Betadisper ######
ExpBetadisper <- betadisper(Dist.spp, Ambiental$Estado_trofico)
permutest(ExpBetadisper, permutations = 9999)


### Plot nMDS TESTE
mnds_zoo <- metaMDS(Zoo, distance = 'bray')
scores(mnds_zoo)
plot(mnds_zoo, type = 'text')

### Plot NMDS
op_lagoa2 <- ordiplot(mnds_zoo, type = 'n')
# Definando as cores
cols = c(col = 1:7)
#plotando os pontos
points(mnds_zoo, cex = 1, pch = 16, col = cols[Ambiental$Estado_trofico])
#inserindo as linhas ligando os pontos
ordispider(mnds_zoo, groups = Ambiental$Estado_trofico, label = F,col = 1:7)
#inserindo as linas em volta dos pontos
ordihull(mnds_zoo, groups = Ambiental$Estado_trofico, lty = 'dotted',col = 1:7)

#Opcional se quiser inserindo elipses com o intervalo 
#de confiança de 95% (conf=0.95) retirar o # da linha abaixo
#ordiellipse(mnds_zoo, groups = Ambiental$Estado_trofico,col = 1:7,conf=0.95)

#inserindo legendas (mudar o título da legenda m title=)
legend(title="Legenda","topright", pch = 16, col = cols, 
       legend = levels(Ambiental$Estado_trofico), cex=0.8)
