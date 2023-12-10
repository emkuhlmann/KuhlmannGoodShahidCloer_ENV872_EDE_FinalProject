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
          alpha.regions = 2)

counties_all
