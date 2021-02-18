library(tidyverse)
library(rgdal)
library(maptools)
library(broom)
library(ggplot2)
if (!require(gpclib)) install.packages("gpclib", type="source")
gpclibPermit()

emergency_food <- read.csv("https://data.seattle.gov/api/views/kkzf-ntnu/rows.csv?accessType=DOWNLOAD")
zipcode_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/zip_code_city.csv")
covid_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/overall-counts-rates-geography-feb-10.csv")

zipcode_data <- zipcode_data %>%
  mutate(Zip = str_trim(as.character(Zip)))

emergency_food_by_city <- emergency_food %>%
  mutate(Zip = str_extract(Address, ".{5}$")) %>%
  select(Agency, Address, Zip) %>%
  left_join(zipcode_data, by = "Zip") %>%
  group_by(City) %>%
  summarize(num_food_sources = n()) %>%
  rename(Location_Name = City) %>%
  mutate(Location_Name = str_trim(Location_Name))

max_emergency_fs_city <- emergency_food_by_city %>%
  filter(num_food_sources == max(num_food_sources)) %>%
  pull(Location_Name)

min_emergency_fs_city <- emergency_food_by_city %>%
  filter(num_food_sources == min(num_food_sources)) %>%
  pull(Location_Name)

covid_data_to_fs_by_city <- covid_data %>%
  select(Location_Name, Positives, Deaths) %>%
  filter(Location_Name != "All King County") %>%
  mutate(Location_Name = str_trim(Location_Name))

combined_data <- left_join(emergency_food_by_city, 
                           covid_data_to_fs_by_city, 
                           by = "Location_Name") %>% 
  filter(Positives != is.nan(Positives)) %>%
  filter(Location_Name != is.nan(Deaths)) %>%
  filter(num_food_sources != is.nan(num_food_sources)) %>%
  mutate(deaths_per_fs = round(Deaths / num_food_sources)) %>%
  mutate(positives_per_fs = round(Positives / num_food_sources))

max_deaths_per_fs_city <- combined_data %>% 
  filter(deaths_per_fs == max(deaths_per_fs)) %>%
  pull(Location_Name)

min_deaths_per_fs_city <- combined_data %>% 
  filter(deaths_per_fs == min(deaths_per_fs)) %>%
  pull(Location_Name)
  

my_spdf <- readOGR(
  dsn= paste(getwd(),"/data/Municipal_Boundaries-shp/", sep = ""),
  layer= "Municipal_Boundaries",
  verbose=FALSE
)

spdf_fortified <- tidy(my_spdf, region = "CITYNAME")

spdf_fortified <- spdf_fortified %>%
  rename(Location_Name = id) %>%
  left_join(combined_data, by="Location_Name")

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
positives_per_fs_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = positives_per_fs), 
               color="white") +
  scale_fill_gradient2(
    "Positives per Food Source",
    low = "white",
    mid = "yellow",
    high = "blue"
  ) +
  blank_theme +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "King County Positive Tests")

# print(deaths_map) to view the map
deaths_per_fs_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = deaths_per_fs), 
               color="white") +
  scale_fill_gradient2(
    "Deaths per Food Source",
    low = "white",
    mid = "yellow",
    high = "red"
  ) +
  blank_theme + 
  coord_map() +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "King County Covid Deaths") 
