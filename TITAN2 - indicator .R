##Tutorial 
##https://mran.microsoft.com/snapshot/2017-08-06/web/packages/TITAN2/vignettes/glades.TITAN.html

library(TITAN2)
data(glades.taxa)
str(glades.taxa, list.len = 5)
data(glades.env)
str(glades.env)
#glades.titan <- titan(glades.env, glades.taxa)

glades.titan <- titan(glades.env, glades.taxa, minSplt = 5, numPerm = 250, boot = TRUE, nBoot = 5, 
                      imax = FALSE, ivTot = FALSE, pur.cut = 0.95, rel.cut = 0.95, ncpus = 1, memory = FALSE)

data(glades.titan)
plotsum <- plotSumz(glades.titan, filter = TRUE)
plotTaxa(glades.titan,xlabel = "Surface Water TP (ug/l)",z.med = T)
plotTaxa(glades.titan, xlabel = "Surface Water TP (ug/l)", z.med = F, prob95 = T)
plotCPs(glades.titan)


par(mar=c(0,0,0,0))
    