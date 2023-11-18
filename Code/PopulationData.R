#install.packages("tidycensus")
library(tidycensus)
library(tidyverse)

census_api_key("9821d76d58cfa47ae353a1c89a8f3f4cc706b9a0")


variables <- load_variables(2005, "acs1")
#total population <-	B01003_001

pop_data <- get_acs(geography = "county",
                    variables = c(total_pop = "B01003_001"),
                    state = "CA",
                    year = 2005,
                    survey = "acs1")
#creating a for loop to pull data, ChatGPT helped write this code
population_data <- data.frame()

# Loop over the years 2005-2019
for (year in 2005:2019) {
  # Fetch the data for the specified year
  data <- get_acs(geography = "county", 
                  variables = c(total_pop = "B01003_001"),
                  state = "CA",
                  survey = "acs1",
                  year = year)
  
  # Extract and store the relevant information in the data frame
  population_data <- bind_rows(population_data, 
                               data %>% 
                                 select(NAME, variable, estimate, GEOID) %>% 
                                 mutate(year = year))
}

CA_population <- population_data %>% 
  mutate(County = NAME,
         Population = estimate) %>% 
  select(GEOID, County, year, Population) %>% 
  rename(CountyFIPS = GEOID, Year = year)

CA_population$Year <- as.factor(CA_population$Year)

#saving processed population data
write.csv(CA_population, row.names = FALSE, 
          file = "./Data/Processed/CA_population_data.csv")
