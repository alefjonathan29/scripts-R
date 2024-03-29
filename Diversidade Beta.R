#Beta.Multi
#####Diversidade Beta Taxon�mica#####
library(betapart)
library(vegan)

#Abrir planilha

total<-read.table("biotica_semiarido.txt",h=T)

umida<-ifelse(total[,3:ncol(total)]>0,1,0) #tirando as duas primeiras colunas categ�ricas

aleat<-99
matrixumida<-matrix(NA,aleat,3) #criando matrix p armazenar os dados, aleatorizando 2 vezes. NA / p dizer q � matrix vazia. e com 3 colunas (Bsor, Bnes e B)
colnames(matrixumida)<-c("Sor", "Sim", "Nes") #dando nome as colunas
i=1
for(i in 1: aleat){
  umidacorrigida<-umida[sample.int(21,10),] #escolher as 10 lagoas
  umidacorrigida1<-specnumber(umidacorrigida,MARGIN = 2) #Fun��o specnumber localiza o n�mero de esp�cies. Com MARGEM = 2, encontra frequ�ncias de esp�cies
  umidacorrigida<-umidacorrigida[,umidacorrigida1>0]
  betatax.umi<-beta.multi(umidacorrigida,index.family = "sor") #faz a parti��o da beta
  matrixumida[i,1]<-betatax.umi$beta.SOR
  matrixumida[i,2]<-betatax.umi$beta.SIM
  matrixumida[i,3]<-betatax.umi$beta.SNE
  
  
} 

write.table(matrixumida,"resultadosemiaridotaxonomica.txt",sep="\t")
