# visualizing wildfire data across California 

# working directory set to be KuhlmannGoodShahidCloer_ENV872_FinalProject  

library(readr)
library(here)
library(dplyr)
library(ggplot2)
library(tidyverse)

wildfire_df <- read.csv(here("Data/Processed/CA_wildfire_processed.csv"))


wildfire_df <- wildfire_df %>%
  rename(County = UNIT,
         Year = YEAR,
         acres_burned = mean)

# ----- wildfire heatmap by county ---------------------------------------------

wildfire_heatmap <- ggplot(wildfire_df, 
                           aes(x = Year, y = County, fill = acres_burned)) +
  geom_tile() +
  scale_fill_distiller(name = "Acres Burned",
                       palette = "YlOrBr",
                       direction = -1) +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 8),
        legend.key.size = unit(1, "lines")) +
  scale_x_continuous(limits = c(2007, 2020), 
                     breaks = c(2008, 2010, 2012, 2014, 2016, 2018, 2020)) +
  labs(title = "Acres burned by wildfire in each CA county, 2008 - 2019")

print(wildfire_heatmap)
