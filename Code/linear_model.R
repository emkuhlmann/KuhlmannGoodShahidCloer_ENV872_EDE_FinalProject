library(dplyr)
library(here)
library(tidyverse)

# ----- load datasets ----------------------------------------------------------

airquality_df <- read.csv(here("Data/Processed/CA_AQ_processed.csv"))
asthma_df <- read.csv(here("Data/Processed/Asthma_data_processed.csv"))
poverty_df <- read.csv(here("Data/Processed/Poverty1_processed.csv"))
wildfire_df <- read.csv(here("Data/Processed/CA_wildfire_processed.csv"))
births_df <- read.csv(here("Data/Processed/birth_percent_counties_Processed.csv"))

# ----- a little bit of reordering and renaming --------------------------------

airquality_pm <- airquality_df %>%
  filter(Pollutant.Standard == "PM25 Annual 2012") %>%
  select(c(Year,
           County.Name,
           Arithmetic.Mean)) %>%
  rename(County = County.Name) %>%
  group_by(County, Year) %>%
  summarise(mean_pm = mean(Arithmetic.Mean))

airquality_ozone <- airquality_df %>%
  filter(Pollutant.Standard == "Ozone 8-hour 2015") %>%
  select(c(Year,
           County.Name,
           Arithmetic.Mean)) %>%
  rename(County = County.Name) %>%
  group_by(County, Year) %>%
  summarise(mean_ozone = mean(Arithmetic.Mean))

asthma_df <- asthma_df %>%
  select(c(Year,
           County,
           visits_per100k))

poverty_df <- poverty_df %>%
  select(c(Year,
           County,
           Percent_Poverty))
# poverty is missing San Bernardino county

wildfire_df <- wildfire_df %>%
  rename(County = UNIT,
         Year = YEAR,
         acres_burned = mean)
# note that data is 2008 through 2019 and if a county doesn't have a year it's 
# because no acreage was burned 

births_df <- births_df %>%
  select(c(Year,
           County,
           Value)) %>%
  filter(Year != "2020") %>%
  filter(County != "Amador") %>%
  rename(births_percent = "Value")

# ----- join into one data frame -----------------------------------------------

listed_df <- list(airquality_ozone,
                  airquality_pm,
                  asthma_df,
                  poverty_df,
                  wildfire_df,
                  births_df)

joined_df <- listed_df %>%
  reduce(full_join, by = c("Year", "County"))

# ----- testing out the asthma MLR ---------------------------------------------

# first pass using everything as predictors 
asthma_regression <- lm(data = joined_df,
                        visits_per100k ~ Year + 
                        County +
                        mean_ozone +
                        mean_pm +
                        Percent_Poverty +
                        acres_burned)
summary(asthma_regression)
  # this looks crazy - not sure how to interpret the counties as predictors?
  # might make more sense to try and anova - see how asthma is difference across
  # counties 

# how does removing Year and County affect regression?
asthma_regression_2 <- lm(data = joined_df,
                        visits_per100k ~  
                          mean_ozone +
                          mean_pm +
                          Percent_Poverty +
                          acres_burned)
summary(asthma_regression_2)
  # now air quality and poverty are significant predictors; wildfire is not 

# ----- testing out births MLR -------------------------------------------------

# first pass using everything as predictors 
births_regression <- lm(data = joined_df,
                        births_percent ~ Year + 
                          County +
                          mean_ozone +
                          mean_pm +
                          Percent_Poverty +
                          acres_burned)
summary(births_regression)

# how does removing Year and County affect regression?
births_regression_2 <- lm(data = joined_df,
                          births_percent ~  
                            mean_ozone +
                            mean_pm +
                            Percent_Poverty +
                            acres_burned)
summary(births_regression_2)
