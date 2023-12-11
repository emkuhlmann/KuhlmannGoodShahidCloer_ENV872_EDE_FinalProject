library(here)
library(tidyverse)
library(ggplot2)

Asthma_data_processed <- read.csv("./Data/Processed/Asthma_data_processed.csv", 
                                  stringsAsFactors = T)

#regular heatmap
AsthmaVisits_heatmap <- ggplot(Asthma_data_processed, 
                               aes(x = Year, y = County, fill = visits_per100k)) +
  geom_tile() +
  scale_fill_distiller(name = "ED Visits for Asthma per 100k",
                       palette = "YlOrBr",
                       breaks = c(100, 300, 500, 700),
                       direction = 1) +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 8),
        legend.key.size = unit(1, "lines"))

AsthmaVisits_heatmap

#interactive heatmap
int_heatmap <- ggplotly(AsthmaVisits_heatmap)
int_heatmap