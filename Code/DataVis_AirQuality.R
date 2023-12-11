# visualizing pollutant data across California 

# working directory set to be KuhlmannGoodShahidCloer_ENV872_FinalProject  

library(readr)
library(here)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(Kendall)
library(agricolae)
library(ggpubr)

airquality_df <- read.csv(here("Data/Processed/CA_AQ_processed.csv"))

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

# ----- PM2.5 box and whiskers plot by county ----------------------------------

pm_plot <- ggplot(airquality_pm, 
                  aes(x = County, y = mean_annual_PM25)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Annual mean PM2.5 concentrations for each county, 2005 - 2019",
       x = "County", y = "Annual mean PM2.5 (ug/m3)") +
  ylim(0,30)
print(pm_plot)

# ----- ozone box and whiskers plot by county ----------------------------------

ozone_plot <- ggplot(airquality_ozone, 
                  aes(x = County, y = mean_annual_ozone)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Annual mean ozone concentrations for each county, 2005 - 2019",
       x = "County", y = "Annual mean ozone (ppm)") +
  ylim(0,0.07)
print(ozone_plot)

# ----- stacked box and whiskers plots -----------------------------------------

ggarrange(pm_plot, 
          ozone_plot,
          nrow = 2)

# ----- PM2.5 time series ------------------------------------------------------

pm_annual_avg <- airquality_pm %>%
  group_by(Year) %>%
  summarise(mean_annual_pm = mean(mean_annual_PM25))

pm_timeseries_plot <- 
  ggplot(pm_annual_avg,
         aes(x = Year,
             y = mean_annual_pm)) +
  labs(title = "Annual average PM2.5 across all CA counties, 2005 - 2019",
       y = "Avg PM2.5 (ug/m3)") +
  ylim(0,13) +
  theme(axis.text.x = element_text(size = 14)) +
  theme(axis.text.y = element_text(size = 14)) +
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14)) +
  geom_point(size = 2) +
  geom_smooth(method=lm)

print(pm_timeseries_plot)

pm_ts <- ts(pm_annual_avg$mean_annual_pm,
            start = 2005,
            end = 2019,
            frequency = 1)

MannKendall(pm_ts)
# 2-sided pvalue = 0.022822

pm_regression <- lm(data = pm_annual_avg,
                    mean_annual_pm ~ Year)
summary(pm_regression)

# ----- ozone time series ------------------------------------------------------

ozone_annual_avg <- airquality_ozone %>%
  group_by(Year) %>%
  summarise(mean_annual_ozone = mean(mean_annual_ozone))

ozone_timeseries_plot <- 
  ggplot(ozone_annual_avg,
         aes(x = Year,
             y = mean_annual_ozone)) +
  labs(title = "Annual average ozone across all CA counties, 2005 - 2019",
       y = "Avg ozone (ppm)") +
  ylim(0,0.1) +
  theme(axis.text.x = element_text(size = 14)) +
  theme(axis.text.y = element_text(size = 14)) +
  theme(axis.title.x = element_text(size = 14)) +
  theme(axis.title.y = element_text(size = 14)) +
  geom_point(size = 2) +
  geom_smooth(method=lm)

print(ozone_timeseries_plot)

ozone_ts <- ts(ozone_annual_avg$mean_annual_ozone,
            start = 2005,
            end = 2019,
            frequency = 1)

MannKendall(ozone_ts)
# 2-sided pvalue = 0.37305

# ----- stacked time series plots ----------------------------------------------

ggarrange(pm_timeseries_plot,
          ozone_timeseries_plot,
          nrow = 2)

# ----- PM2.5 ANOVA by county --------------------------------------------------

pm_anova <- aov(data = airquality_pm,
                mean_annual_PM25 ~ County)

pm_county_groups <- HSD.test(pm_anova, 
                             "County", 
                            group = TRUE)
pm_county_groups

# ----- ozone ANOVA by county --------------------------------------------------

ozone_anova <- aov(data = airquality_ozone,
                   mean_annual_ozone ~ County)

ozone_county_groups <- HSD.test(ozone_anova, 
                                "County", 
                                group = TRUE)
ozone_county_groups
