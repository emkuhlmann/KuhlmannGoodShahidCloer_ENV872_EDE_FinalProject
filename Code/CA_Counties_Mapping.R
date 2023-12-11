#----------------------Mapping counties-----------------------------------------
#from ChatGPT
library(mapview)
library(sf)
#install.packages("tigris")
library(tigris)

# Load California counties data
ca_counties <- tigris::counties(state = "CA", cb = TRUE)

# Simplify the geometry for better performance
ca_counties <- st_simplify(ca_counties, dTolerance = 0.01)

# List of counties to include
counties_to_include <- c(
  "Alameda", "Butte", "Contra Costa", "Fresno", "Humboldt", "Imperial", "Kern",
  "Kings", "Lake", "Los Angeles", "Mendocino", "Merced", "Monterey", "Nevada",
  "Orange", "Placer", "Riverside", "Sacramento", "San Bernardino", "San Diego",
  "San Francisco", "San Joaquin", "San Luis Obispo", "San Mateo", "Santa Barbara",
  "Santa Clara", "Santa Cruz", "Shasta", "Solano", "Sonoma", "Stanislaus", 
  "Sutter", "Tulare", "Ventura", "Yolo"
)

# Filter the dataframe
filtered_ca_counties <- ca_counties[ca_counties$NAME %in% counties_to_include, ]

filtered_ca_counties <- filtered_ca_counties %>% 
  rename(County = NAME)
filtered_ca_counties$County <- as.factor(filtered_ca_counties$County)

#install.packages("Polychrome")
library(Polychrome)
P35 = createPalette(35,  c("#ff0000", "#00ff00", "#0000ff"))

#----------------------------Mapping only the counties included-----------------
counties_35 <- mapview(filtered_ca_counties, col.regions = P35, zcol = "County",
        layer.name = "Counties Included in the Anaysis")

#----------------------------Mapping all counties ------------------------------
counties_all <- mapview(ca_counties, zcol = "NAME", col.regions = "plum1", 
                        legend = F, map.types = mapviewGetOption("CartoDB.Positron"),
                        alpha.regions = 0.5) +
  mapview(filtered_ca_counties, zcol = "County", col.regions = "darkmagenta", 
          alpha.regions = 2, layer.name = "Counties Included in the Anaysis")

counties_all

#----------------------------Mapping with ggplot-------------------------------
# Define the colors and labels for the legend
legend_colors <- c("All Counties" = "thistle", "Counties Included in Analysis" = "orchid4")

#mapping
gg_counties_all <- ggplot() +
  geom_sf(data = ca_counties, aes(fill = "All Counties"), color = "white") +
  geom_sf(data = filtered_ca_counties, aes(fill = "Counties Included in Analysis"), color = "white") +
  labs(fill = "County") + 
  scale_fill_manual(name = "County", values = legend_colors) +
  ggtitle("California Counties Included in this Analysis")

gg_counties_all

# ----- including the air monitor sites on the maps ----------------------------

airquality_df <- read.csv(here("Data/Processed/CA_AQ_processed.csv"))

pm_df <- airquality_df %>%
  filter(Pollutant.Standard == "PM25 Annual 2012")

ozone_df <- airquality_df %>%
  filter(Pollutant.Standard == "Ozone 8-hour 2015")

pm_sf <- pm_df %>%
  st_as_sf(coords = c('Longitude', 'Latitude'),
           crs = 4326)

ozone_sf <- ozone_df %>%
  st_as_sf(coords = c('Longitude', 'Latitude'),
           crs = 4326)

gg_counties_pm <- ggplot() +
  geom_sf(data = ca_counties, aes(fill = "All Counties"), color = "white") +
  geom_sf(data = filtered_ca_counties, aes(fill = "Counties Included in Analysis"), color = "white") +
  geom_sf(data = pm_sf) +
  labs(fill = "County") + 
  scale_fill_manual(name = "County", values = legend_colors) +
  ggtitle("Location of PM2.5 Monitors")

gg_counties_pm

gg_counties_ozone <- ggplot() +
  geom_sf(data = ca_counties, aes(fill = "All Counties"), color = "white") +
  geom_sf(data = filtered_ca_counties, aes(fill = "Counties Included in Analysis"), color = "white") +
  geom_sf(data = ozone_sf) +
  labs(fill = "County") + 
  scale_fill_manual(name = "County", values = legend_colors) +
  ggtitle("Location of Ozone Monitors")

gg_counties_ozone

# ----- side by side air quality monitor maps ----------------------------------

ggarrange(gg_counties_pm,
          gg_counties_ozone,
          nrow = 1,
          common.legend = TRUE,
          legend = "bottom")
