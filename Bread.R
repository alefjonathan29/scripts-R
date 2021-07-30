install.packages("plotrix")
library(plotrix)
x <- c(1:5, 6.9, 7)
y <- 2^x
from <- 33
to <- 110
plot(x, y, type="b", xlab="index", ylab="value")
barplot(value,month~cat, data=dados, ylim=c(0, NA), pch=1, col="red")
plotpoints(value~month, data=dados, pch=2, col="blue", add=T)
gap.plot(x, y, gap=c(from,to), type="b", xlab="index", ylab="value")
axis.break(2, from, breakcol="snow", style="gap")
axis.break(2, from*(1+0.02), breakcol="black", style="slash")
axis.break(4, from*(1+0.02), breakcol="black", style="slash")
axis(2, at=from)


nmds_lagoa2 <- metaMDS(value~mont)
scores(nmds_lagoa2)
plot(value~month, type = 'text')

op_lagoa2 <- ordiplot(dados$value, type = 'n')
cols = c('grey','black','green','red')
points(dados$value, cex = 1, pch = 2, col = cols[dados$cat])
