install.packages('ssdtools')
library(ssdtools)
library(ggplot2)

# read dataset
data <- ssdtools::boron_data
# fix unacceptable column names
colnames(data) <- make.names(colnames(data))

# fit distributions
dist <- ssd_fit_dists(data, left = 'Conc', dists = c('lnorm'))

normal <- data.frame(dist$lnorm$data) 
normal
data1 <- cbind(data,normal)


# plot distributions
autoplot(dist)
# goodness of fit table
ssd_gof(dist)

# save plot
# width and height are in inches, dpi (dots per inch) sets resolution
ggsave('fit_dist_plot.png', width = 8 , height = 7 , dpi = 850)

# plot model average
# set the nboot argument and set ci = TRUE in ssd_plot to add confidence intervals to plot.
# we reccommend using nboot = 10000, although this may take half a day to run
pred <- predict(dist, nboot = 10L)
pred
ssd_plot(data, pred, left = 'Conc', label = 'Species', color = 'Group', shape = 'Group', hc = 5L, ci = FALSE,
         shift_x = 1.2, xlab = 'Concentration', ylab = 'Percent of Species Affected') +
  ggtitle('') +
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = NA, colour='black'),
        axis.text = element_text(color = 'black'),
        legend.key = element_rect(fill = NA, colour = NA)) +
  expand_limits(x = 70.7) +
  scale_color_brewer(palette = 'Set1', name = 'Group') +
  scale_shape(name = 'Group')

# save plot
# width and height are in inches, dpi (dots per inch) sets resolution
ggsave('model_average_plot.png', width = 8 , height = 6 , dpi = 400)