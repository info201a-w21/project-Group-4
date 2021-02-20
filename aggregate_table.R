library(tidyverse)

# Map/Table Data
#-------------------------------------------------------------------------------
emergency_food <- 
  read.csv("https://data.seattle.gov/api/views/kkzf-ntnu/rows.csv?accessType=DOWNLOAD")
zipcode_data <- 
  read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/zip_code_city.csv")
covid_data <- 
  read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/overall-counts-rates-geography-feb-10.csv")

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

#-------------------------------------------------------------------------------
