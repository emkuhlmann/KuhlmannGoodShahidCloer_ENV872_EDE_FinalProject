# visualizing pollutant data across California 

# working directory set to be KuhlmannGoodShahidCloer_ENV872_FinalProject  

library(readr)
library(dplyr)
library(ggplot2)
library(tidyverse)

CA_AQ_processed <- read_csv("Data/Processed/CA_AQ_processed.csv")
CA_AQ_processed$Year <- as.factor(CA_AQ_processed$Year)

# get a count of each pollutant type 
table(CA_AQ_processed$`Pollutant Standard`)

# CO 1-hour 1971   NO2 1-hour 2010 Ozone 8-hour 2015  PM25 Annual 2012   SO2 1-hour 2010 
# 1123             1589            2941               2407               514

# example PM2.5 heatmap
PM_heatmap <- ggplot(CA_AQ_processed %>%
                       filter(`Pollutant Standard` == "PM25 Annual 2012"), 
                     aes(x = `Year`, y = `County Name`, fill = `Arithmetic Mean`)) +
  geom_tile() +
  scale_fill_distiller(name = "PM2.5 (ug/m3)", palette = "Spectral",
                       direction = -1)
PM_heatmap

# example group by and summarize for annual PM2.5 for whole state 
# read in CA_AQ_processed again so year is as numeric 
CA_pm25 <- CA_AQ_processed %>%
  select(c(`Pollutant Standard`, Year, `Arithmetic Mean`)) %>%
  filter(`Pollutant Standard` == "PM25 Annual 2012") %>%
  group_by(`Year`) %>%
  filter(!is.na(`Arithmetic Mean`)) %>%
  summarise(meanPM25 = mean(`Arithmetic Mean`))

# plot time series of PM2.5 for whole state
PM_CA_avg_scatter <- 
  ggplot(CA_pm25,
         aes(x = Year,
             y = meanPM25)) +
  labs(title = "Annual average PM2.5 across all CA counties",
       y = "Avg PM2.5 (ug/m3)") +
  ylim(0,13) +
  theme(axis.text.x = element_text(size = 14)) +
  theme(axis.text.y = element_text(size = 14)) +
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14)) +
  geom_point(size = 2) +
  geom_smooth(method=lm)

PM_CA_avg_scatter

PM_county_unique <- CA_AQ_processed %>%
  filter(`Pollutant Standard` == "PM25 Annual 2012")

PM_county_unique <- PM_county_unique %>%
  na.omit(`Arithmetic Mean`)

unique(PM_county_unique$`County Name`)
