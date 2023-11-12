library(here)
library(tidyverse)
library(ggplot2)
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

#plotting annual visits by county
ED_Visits <- ggplot(Asthma_ED, aes(x = factor(CountyFIPS), y = Visits, fill = Year)) +
  geom_col()

ED_Visits

#annual visits across all counties
YearlyVisits <- ggplot(Asthma_ED, aes(x = Year, y = Visits)) +
  geom_col()

YearlyVisits

#saving processed data
write.csv(Asthma_ED, row.names = FALSE, 
          file = "./Data/Processed/Asthma_ED_Visits_Processed.csv")
