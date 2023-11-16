#install.packages("tidycensus")
library(tidycensus)

census_api_key("9821d76d58cfa47ae353a1c89a8f3f4cc706b9a0")
install = TRUE

variables <- load_variables(2005, "acs1")
#total population <-	B01003_001

pop_data <- get_acs(geography = "county",
                    variables = c(total_pop = "B01003_001"),
                    state = "CA",
                    year = 2005,
                    survey = "acs1")
