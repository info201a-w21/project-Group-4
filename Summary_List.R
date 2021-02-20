# A function that takes in a dataset and returns a list of info about it:

source("aggregate_table.R")


summary_info <- list(combined_data)
summary_info$num_cities <- nrow(combined_data)
summary_info$some_min_value <- min_emergency_fs_city
summary_info$