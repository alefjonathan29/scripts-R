library(ggRandomForests)
## Examples from RFSRC package...
## ------------------------------------------------------------
## classification example
## ------------------------------------------------------------
## ------------- iris data
## You can build a randomForest
rfsrc_iris <- rfsrc(Species ~ ., data = iris)
# ... or load a cached randomForestSRC object
data(rfsrc_iris, package="ggRandomForests")
# Get a data.frame containing error rates
gg_dta<- gg_error(rfsrc_iris)
# Plot the gg_error object
plot(gg_dta)
## ------------------------------------------------------------
## Regression example
## ------------------------------------------------------------
## Not run:
## ------------- airq data
rfsrc_airq <- rfsrc(Ozone ~ ., data = airquality, na.action = "na.impute")
# Get a data.frame containing error rates
gg_dta<- gg_error(rfsrc_airq)
# Plot the gg_error object
plot(gg_dta)
## End(Not run)
## Not run:
## ------------- Boston data
data(rfsrc_Boston, package="ggRandomForests")
# Get a data.frame containing error rates
gg_dta<- gg_error(rfsrc_Boston)
# Plot the gg_error object
plot(gg_dta)