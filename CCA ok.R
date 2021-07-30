# Analise de correspondencia canonica
library(vegan) # pacote para correspondencia canonica
library(ade4)


dados <- read.csv("CCA1.csv", header = T,  sep = ';') # para rodar os dados, seleciona e executa q abre os dados
attach(dados)                  
summary(dados)

dados$SACW <- as.factor(dados$SACW)
summary(dados)

esp <- as.matrix(dados[,10:13])     # Forma uma matriz de abundancias
amb <- as.matrix(dados[,6:8])  # Forma uma matriz de dados ambientais


mod <- cca(log(esp+1), scale(amb))
#mod <- rda(esp,amb)
#mod <- prcomp(esp,amb)

summary(mod)
RsquareAdj(mod)
anova.cca(mod)

#text(mod, dis="cn", mul=2)
plot(mod)

#ajesp <- envfit(mod,esp,perm=1000)
#ajamb <- envfit(mod,amb,perm=1000)

plot(mod, type="n")# ylim=c(-10,10),xlim=c(-10,20))
cols = c('#f8766d','#83b0fc','#00ba38')
pchs = c(16:18)
points(mod, cex = 0.8, pch = pchs[dados$SACW], col = cols[dados$SACW])
plot(ajamb, cex=0.7, col="blue")
plot(ajesp, cex=0.7, col="red")
legend("bottomleft", pch = pchs, col = cols, legend = levels(dados$SACW),pt.bg=1:4, bty="n")


#pt.bg=1:4, bty="n"
