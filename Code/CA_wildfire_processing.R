library(dplyr)
library(data.table)

years <- seq(2008,2019)

fileName <- sprintf("%s.csv", years)
filePath <- file.path("./Data/Raw/CA_wildfire", fileName)

# reading each year csv file into a list 
file_contents <- list()

for(i in seq_along(filePath)) {
  file_contents[[i]] <- readr::read_csv(
    file = filePath[[i]]
  )
}


data_list <- list()

for(i in seq_along(file_contents)) {
  
  data_list[[i]] <- file_contents[[i]] %>%
    
    group_by(`UNIT`, `YEAR`) %>%
    summarise(mean = mean(`ACRES BURNED`))
  
}

# creating a data frame from the list 
data_df <- rbindlist(data_list)

# filter for our list of counties 
counties <- c("Alameda",
              "Butte",
              "Contra Costa",
              "Fresno",
              "Humboldt",
              "Imperial",
              "Kern",
              "Kings",
              "Lake",
              "Los Angeles",
              "Mendocino",
              "Merced",
              "Monterey",
              "Nevada",
              "Orange",
              "Placer",
              "Riverside",
              "Sacramento",
              "San Bernardino",
              "San Diego",
              "San Francisco",
              "San Joaquin",
              "San Luis Obispo",
              "San Mateo",
              "Santa Barbara",
             "Santa Clara",
              "Santa Cruz",
              "Shasta",
              "Solano",
              "Sonoma",
              "Stanislaus",
              "Sutter",
              "Tulare",
              "Ventura",
              "Yolo")

data_df <- data_df %>%
  filter(`UNIT` %in% counties)

unique(data_df$UNIT)

write.csv(data_df, row.names = FALSE, file = "./Data/Processed/CA_wildfire_processed.csv")
