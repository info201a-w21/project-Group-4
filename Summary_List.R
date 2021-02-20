# A function that takes in a dataset and returns a list of info about it:
library(dplyr)
source("aggregate_table.R")


summary_info <- list(combined_data)
summary_info$num_cities <- nrow(combined_data)
summary_info$some_min_value <- min_emergency_fs_city

summary_info$highest_death_cities <- combined_data %>%
  filter(Deaths == min(Deaths, na.rm = T)) %>%
  pull(Location_Name)

summary_info$highest_deaths_fs <- combined_data %>%
  filter(deaths_per_fs == max(deaths_per_fs)) %>%
  pull(Location_Name)

summary_info$highest_cases_fs <- combined_data %>%
  filter(positives_per_fs == max(positives_per_fs)) %>%
  pull(Location_Name)
