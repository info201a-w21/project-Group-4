# Bar graph of deaths by age group in King County

library(tidyverse)
age_data <- 
  read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/nts-by-date-all-demographics-jan-19.csv")

percentage <- age_data %>%
  group_by(Age_Group) %>%
  summarize(Percentage_of_Deaths = sum(Deaths) / Population) %>%
  distinct() %>%
  filter(Percentage_of_Deaths != "NaN")

# percentage of deaths by age group
bar_graph <- ggplot(percentage) +
  geom_col(mapping = aes(x = Age_Group, y = Percentage_of_Deaths)) +
  scale_y_continuous(labels = scales::percent) +
  ggtitle("Percentage of COVID-19 Deaths by Age Group in King County") +
  labs(x = "Age Group", y = "Percentage of Deaths")
