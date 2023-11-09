library(here)
library(tidyverse)
#importing dataset and replacing "suppressed" entries in the values column as NAs
CA_Asthma_EDVisits <- read.csv(here("Data/Raw/CA_Asthma_EDVisits.csv"), 
                               stringsAsFactors = T, 
                               na.strings = c("Suppressed"))
colnames(CA_Asthma_EDVisits)
summary(CA_Asthma_EDVisits) #14 NAs in the value column, coming from Sierra and Alpine counties
summary(CA_Asthma_EDVisits$County) #15 values per county, one per year


         