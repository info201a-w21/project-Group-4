library(tidyverse)
library(rgdal)
library(maptools)
library(broom)
library(ggplot2)
if (!require(gpclib)) install.packages("gpclib", type = "source")
gpclibPermit()

source("aggregate_table.R")

max_deaths_per_fs_city <- combined_data %>% 
  filter(deaths_per_fs == max(deaths_per_fs)) %>%
  pull(Location_Name)

min_deaths_per_fs_city <- combined_data %>% 
  filter(deaths_per_fs == min(deaths_per_fs)) %>%
  pull(Location_Name)
  
my_spdf <- readOGR(
  dsn = paste0(getwd(), "/data/Municipal_Boundaries-shp/"),
  layer = "Municipal_Boundaries",
  verbose = FALSE
)

#my_spdf <- readOGR(
#  dsn = "/data/Municipal_Boundaries-shp/",
#  layer = "Municipal_Boundaries",
#  verbose = FALSE
#)

# 
# my_spdf <- readOGR(
#   dsn=paste0(getwd(), "data/Municipal_Boundaries-shp"),
#   layer= "Municipal_Boundaries.shp",
#   verbose=FALSE
# )
# tmp <- path.expand(paste0(getwd(), "data/Municipal_Boundaries-shp"))
# readOGR(dsn = "C:/Users/abbie/info201/project-Group-4data/Municipal_Boundaries-shp", layer = "Municipal_Boundaries")
# tmp <- readOGR(paste0(getwd(), "data/Municipal_Boundaries-shp", "Municipal_Boundaries.shp"))

spdf_fortified <- tidy(my_spdf, region = "CITYNAME")

spdf_fortified <- spdf_fortified %>%
  rename(Location_Name = id) %>%
  left_join(combined_data, by = "Location_Name")

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

positives_per_fs_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = positives_per_fs), 
               color = "white") +
  scale_fill_gradient2(
    "Positives per Food Source",
    low = "white",
    mid = "yellow",
    high = "blue"
  ) +
  blank_theme +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "King County Positive Tests per Food Source")

deaths_per_fs_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = deaths_per_fs), 
               color = "white") +
  scale_fill_gradient2(
    "Deaths per Food Source",
    low = "white",
    mid = "yellow",
    high = "blue"
  ) +
  blank_theme + 
  coord_map() +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "King County Covid Deaths per Food Source") 

deaths_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = Deaths), 
               color = "white") +
  scale_fill_gradient2(
    "Deaths",
    low = "white",
    mid = "yellow",
    high = "blue"
  )  +
  blank_theme + 
  coord_map() +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "King County Covid Deaths") 

positives_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = Positives), 
               color = "white") +
  scale_fill_gradient2(
    "Positives",
    low = "white",
    mid = "yellow",
    high = "blue"
  ) +
  blank_theme + 
  coord_map() +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "King County Covid Positives") 

food_sources_map <- ggplot() +
  geom_polygon(data = spdf_fortified,
               aes(x = long, y = lat, group = group, fill = num_food_sources), 
               color = "white") +
  scale_fill_gradient2(
    "Number of Food Sources",
    low = "white",
    mid = "yellow",
    high = "blue"
  )  +
  blank_theme + 
  coord_map() +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "King County Number of Food Sources") 
