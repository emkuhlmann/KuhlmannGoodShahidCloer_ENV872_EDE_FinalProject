# reading in the AQS Air Quality csv files and making one compact data table

# working directory set to be KuhlmannGoodShahidCloer_ENV872_FinalProject 

library(dplyr)
library(data.table)

years <- seq(2005,2019)

fileName <- sprintf("annual_conc_by_monitor_%s.csv", years)
filePath <- file.path("./Data/Raw/EPA_AQS_annual", fileName)

# reading each year csv file into a list 
file_contents <- list()

for(i in seq_along(filePath)) {
  file_contents[[i]] <- readr::read_csv(
    file = filePath[[i]]
  )
}

# wrangling each data frame in the list to filter for the pollutants of interest
# and by state California 
pollutant_std <- c('Ozone 8-hour 2015',
                   'PM25 Annual 2012',
                   'SO2 1-hour 2010',
                   'NO2 1-hour 2010',
                   'CO 1-hour 1971')

state <- "California"

data_list <- list()

for(i in seq_along(file_contents)) {
  
  data_list[[i]] <- file_contents[[i]] %>%
    
    select(c("Latitude",
           "Longitude",
           "Pollutant Standard",
           "Year",
           "Units of Measure",
           "Arithmetic Mean",
           "State Name",
           "County Name")) %>%
    
    filter(`Pollutant Standard` %in% pollutant_std) %>%
    dplyr::filter(`State Name` == "California")
}

# creating a data frame from the list 
data_df <- rbindlist(data_list)
write.csv(data_df, row.names = FALSE, file = "./Data/Processed/CA_AQ_processed.csv")
