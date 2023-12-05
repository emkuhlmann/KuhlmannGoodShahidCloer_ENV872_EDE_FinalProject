library(here)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(RColorBrewer)
#install.packages("plotly")
library(plotly)
#importing dataset and replacing "suppressed" entries in the values column as NAs
CA_Asthma_EDVisits <- read.csv(here("Data/Raw/CA_Asthma_EDVisits.csv"), 
                               stringsAsFactors = T, 
                               na.strings = c("Suppressed"))
colnames(CA_Asthma_EDVisits)
summary(CA_Asthma_EDVisits) #14 NAs in the value column, coming from Sierra and Alpine counties
summary(CA_Asthma_EDVisits$County) #15 values per county, one per year

#removing the two counties with NAs
Asthma_ED <- CA_Asthma_EDVisits[-c(16:30, 676:690),] 
summary(Asthma_ED)         

#removing the NA columns and State columns and renaming value column
Asthma_ED <- Asthma_ED %>% 
  select(CountyFIPS:Value) %>% 
  rename(Visits = Value) 

#changing visits to numeric and year to factor
Asthma_ED$Visits <- as.numeric(Asthma_ED$Visits)
Asthma_ED$Year <- as.factor(Asthma_ED$Year)

#reading in population data
Cal_pop <- read.csv("./Data/Processed/CA_population_data.csv", 
                    stringsAsFactors = T)

Cal_pop$Year <- as.factor(Cal_pop$Year)

#joining population and asthma data
Asthma_visits_full <- Asthma_ED %>% 
  inner_join(Cal_pop, by = c("CountyFIPS", "Year")) %>% 
  select(CountyFIPS:Visits, Population) %>% 
  rename(County = County.x)

#normalizing ED visits by population -> asthma visits per 100k people
Asthma_vis_normalized <- Asthma_visits_full %>% 
  mutate(visits_per100k = (Visits/Population)*100000) %>% 
  select(CountyFIPS:visits_per100k)

#selecting the correct counties
ED_Visits_processed <- Asthma_vis_normalized[-c(46:60,166:195,241:255,541,587:601),]

unique(ED_Visits_processed$CountyFIPS)

#saving processed data
write.csv(ED_Visits_processed, row.names = F, file = "./Data/Processed/Asthma_data_processed.csv")

##Plotting##

#heatmap with normalized data
AsthmaVisits_heatmap_norm <- ggplot(ED_Visits_processed, 
                               aes(x = Year, y = County, fill = visits_per100k)) +
  geom_tile() +
  scale_fill_distiller(name = "ED Visits per 100k", palette = "RdYlGn",
                       breaks = c(100, 300, 500, 700),
                      direction = -1)
AsthmaVisits_heatmap_norm

#heatmap with raw visits
AsthmaVisits_heatmap <- ggplot(ED_Visits_processed, 
                               aes(x = Year, y = County, fill = Visits)) +
  geom_tile() +
  scale_fill_distiller(name = "ED Visits", palette = "RdYlGn", 
                       breaks = c(100, 300, 500, 700),
                       direction = -1)
AsthmaVisits_heatmap

#interactive heatmap
int_heatmap <- ggplotly(AsthmaVisits_heatmap)
int_heatmap


