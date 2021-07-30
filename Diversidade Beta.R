#Beta.Multi
#####Diversidade Beta Taxonômica#####
library(betapart)
library(vegan)

#Abrir planilha

total<-read.table("biotica_semiarido.txt",h=T)

umida<-ifelse(total[,3:ncol(total)]>0,1,0) #tirando as duas primeiras colunas categóricas

aleat<-99
matrixumida<-matrix(NA,aleat,3) #criando matrix p armazenar os dados, aleatorizando 2 vezes. NA / p dizer q é matrix vazia. e com 3 colunas (Bsor, Bnes e B)
colnames(matrixumida)<-c("Sor", "Sim", "Nes") #dando nome as colunas
i=1
for(i in 1: aleat){
  umidacorrigida<-umida[sample.int(21,10),] #escolher as 10 lagoas
  umidacorrigida1<-specnumber(umidacorrigida,MARGIN = 2) #Função specnumber localiza o número de espécies. Com MARGEM = 2, encontra frequências de espécies
  umidacorrigida<-umidacorrigida[,umidacorrigida1>0]
  betatax.umi<-beta.multi(umidacorrigida,index.family = "sor") #faz a partição da beta
  matrixumida[i,1]<-betatax.umi$beta.SOR
  matrixumida[i,2]<-betatax.umi$beta.SIM
  matrixumida[i,3]<-betatax.umi$beta.SNE
  
  
} 

write.table(matrixumida,"resultadosemiaridotaxonomica.txt",sep="\t")
