library(tidyverse)

emergency_food <- read.csv("https://data.seattle.gov/api/views/kkzf-ntnu/rows.csv?accessType=DOWNLOAD")
zipcode_data <- read.csv("zip_code_city.csv")
covid_data <- read.csv("overall-counts-rates-geography-feb-10.csv")

zipcode_data <- zipcode_data %>%
  mutate(Zip = as.character(Zip)) 

emergency_food_by_city <- emergency_food %>%
  mutate(Zip = str_extract(Address, ".{5}$")) %>%
  select(Agency, Address, Zip) %>%
  left_join(zipcode_data, by = "Zip") %>%
  rename(Location_Name = City) %>%
  group_by(Location_Name) %>%
  summarize(num_fs = n()) %>%
  filter(num_fs != 0 & !is.na(Location_Name))

covid_data_to_fs_by_city <- covid_data %>%
  select(Location_Name, Positives, Deaths) %>%
  filter(Location_Name != "All King County")

  # left_join(emergency_food_by_city, by = "Location_Name") %>%
  # mutate(deaths_per_fs = Deaths / num_food_sources) %>%
  # mutate(positives_per_fs = Positives / num_food_sources)

library(rgdal)
my_spdf <- readOGR( 
  dsn= "Municipal_Boundaries-shp/", 
  layer="Municipal_Boundaries",
  verbose=FALSE
)

par(mar=c(0,0,0,0))
plot(my_spdf, col="black", bg="white", lwd=0.5, border=0.5)

library(broom)
spdf_fortified <- tidy(my_spdf, region = "King County")

library(ggplot2)
ggplot() +
  geom_polygon(data = spdf_fortified, aes( x = long, y = lat, group = group), fill="black", color="white") +
  theme_void() 

