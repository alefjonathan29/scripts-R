#https://education.rstudio.com/blog/2020/07/palmerpenguins-cran/
install.packages("palmerpenguins")
library(tidyverse)
library(palmerpenguins)
data(penguins)
summary(penguins)
plot(bill_length_mm~species,data=penguins)
