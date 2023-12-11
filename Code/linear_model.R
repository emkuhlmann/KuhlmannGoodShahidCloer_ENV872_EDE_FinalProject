library(dplyr)
library(here)
library(tidyverse)
library(sjPlot)
library(agricolae)

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
  rename(mean_annual_PM25 = Arithmetic.Mean) %>%
  group_by(County, Year) %>%
  summarise(mean_annual_PM25 = mean(mean_annual_PM25))

airquality_ozone <- airquality_df %>%
  filter(Pollutant.Standard == "Ozone 8-hour 2015") %>%
  select(c(Year,
           County.Name,
           Arithmetic.Mean)) %>%
  rename(County = County.Name) %>%
  rename(mean_annual_ozone = Arithmetic.Mean) %>%
  group_by(County, Year) %>%
  summarise(mean_annual_ozone = mean(mean_annual_ozone))

asthma_df <- asthma_df %>%
  select(c(Year,
           County,
           visits_per100k)) %>%
  rename(ER_asthma_visits_per_100k = visits_per100k)

poverty_df <- poverty_df %>%
  select(c(Year,
           County,
           Percent_Poverty)) %>%
  rename(percent_poverty = Percent_Poverty)

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
  rename(percent_underweight_births = "Value")

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

asthma_regression <- lm(data = joined_df,
                        ER_asthma_visits_per_100k ~  
                          mean_annual_ozone +
                          mean_annual_PM25 +
                          percent_poverty +
                          acres_burned)
summary(asthma_regression)

tab_model(asthma_regression)

# ----- testing out births MLR -------------------------------------------------

births_regression <- lm(data = joined_df,
                          percent_underweight_births ~  
                            mean_annual_ozone +
                            mean_annual_PM25 +
                            percent_poverty +
                            acres_burned)
summary(births_regression)

tab_model(births_regression)

# ----- anova by county for asthma ---------------------------------------------

asthma_county_anova <- aov(data = joined_df,
                           ER_asthma_visits_per_100k ~ County)

asthma_county_groups <- HSD.test(asthma_county_anova, 
                                 "County", 
                                 group = TRUE)
asthma_county_groups

# Graph the results
asthma_tukey_plot <- ggplot(joined_df, 
                            aes(x = County, y = ER_asthma_visits_per_100k)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  stat_summary(geom = "text", fun = max, vjust = -1, size = 3.5,
               label = c("i", "fg", "i", "hi", "b", "i", "i", "gh", "a", "i",
                         "b", "hi", "i", "c", "i", "hi", "i", "i", "i", "i",
                         "i", "hi", "ef", "i", "i", "i", "ef", "ef", "hi", "i",
                         "i", "cd", "i", "i", "de"
               )) +
  labs(title = "Tukey test groups for annual average ER visits for asthma by county",
       x = "County", y = "Asthma ER Visits per 100k") +
  ylim(0, 800)
print(asthma_tukey_plot)

# ----- anova by county for births ---------------------------------------------

births_anova <- aov(data = joined_df,
                    percent_underweight_births ~ County)

births_county_groups <- HSD.test(births_anova, 
                                 "County", 
                                 group = TRUE)
births_county_groups

# Graph the results
births_tukey_plot <- ggplot(joined_df, 
                            aes(x = County, y = percent_underweight_births)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  stat_summary(geom = "text", fun = max, vjust = -1, size = 3,
               label = c("bcde", "ijklmno", "defghi", "a", "klmnop", "jklmno",
                         "abc", "defghi", "ghijklm", "abcd", "defghi", "efghij", 
                         "ijklmn", "jklmno", "ijhlmn", "p", "defghi", "bcdefg", 
                         "abc", "fghijkl", "defhgi", "ab", "mnop", "fghijk", 
                         "fghijk", "cdefghi", "lmnop", "efghij", "bcdef", "nop",
                         "fghijk", "hijklm", "bcdefgh", "ijklmno", "op"
               )) +
  labs(title = "Tukey test groups for annual percent of low weight births by county",
       x = "County", y = "percent low birth weight") +
  ylim(3, 7)
print(births_tukey_plot)
