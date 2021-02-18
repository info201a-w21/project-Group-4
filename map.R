library(tidyverse)
library(rgdal)
library(maptools)
library(broom)
library(ggplot2)
if (!require(gpclib)) install.packages("gpclib", type="source")
gpclibPermit()

emergency_food <- read.csv("https://data.seattle.gov/api/views/kkzf-ntnu/rows.csv?accessType=DOWNLOAD")
zipcode_data <- read.csv(paste(getwd(),"/data/zip_code_city.csv", sep = ""))
covid_data <- read.csv(paste(getwd(),"/data/overall-counts-rates-geography-feb-10.csv", sep = ""))

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

  # %>%
  # left_join(emergency_food_by_city, by = "Location_Name") 
  # mutate(deaths_per_fs = round(Deaths / num_food_sources)) %>%
  # mutate(positives_per_fs = round(Positives / num_food_sources))

my_spdf <- readOGR(
  dsn= paste(getwd(),"/data/Municipal_Boundaries-shp/", sep = ""),
  layer= "Municipal_Boundaries",
  verbose=FALSE
)

spdf_fortified <- tidy(my_spdf, region = "CITYNAME")

spdf_fortified <- spdf_fortified %>%
  rename(Location_Name = id) %>%
  left_join(covid_data_to_fs_by_city, by="Location_Name")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  )

# print(positives_map) to view the map
positives_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = Positives), color="white") +
  scale_fill_gradient2(
    low = "white",
    mid = "yellow",
    high = "red"
  ) +
  labs(title = "King County Positive COVID Test Distribution") +
  blank_theme +
  theme(plot.title = element_text(hjust = 0.5))

# print(deaths_map) to view the map
deaths_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = Deaths), color="white") +
  scale_fill_gradient2(
    low = "white",
    mid = "yellow",
    high = "red"
  ) +
  labs(title = "King County COVID Deaths Distribution") +
  blank_theme +
  theme(plot.title = element_text(hjust = 0.5))
