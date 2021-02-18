# Bar graph of deaths by age group in King County

library(tidyverse)
age_data <- read.csv(paste(getwd(), "/data/nts-by-date-all-demographics-jan-19.csv", sep = ""))

columns <- age_data %>% 
  select(Deaths, Age_Group) %>% 
  gather(key = Deaths, value = Population, -Age_Group)

ggplot(columns, aes (x = Age_Group, y = Population, fill = condition) +
# geom_col(mapping = aes(x = Age_Group, y = Population, color = "Deaths"))
  geom_bar(position = "stack", stat = "identity"))
                 
 