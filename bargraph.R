# Bar graph of deaths by age group in King County

library(tidyverse)
age_data <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/nts-by-date-all-demographics-jan-19.csv")

age_data <- age_data %>%
  group_by(Age_Group) %>% 
  mutate(
    Total = Population - Deaths,
    Percentage_of_Deaths = Deaths/Population
    )

columns <- age_data %>%
  select(Age_Group, Deaths, Total, Population) %>%
  gather(key = Deaths, value = Population, -Age_Group, -Population)

# stacked bar graph
ggplot(columns) +
  geom_col(mapping = aes(x = Age_Group, y = Population, fill = Deaths))

# bar graph of deaths
ggplot(age_data) +
  geom_col(mapping = aes(x = Age_Group, y = Deaths))

# percentage of deaths by age group
bar_graph <- ggplot(age_data) +
  geom_col(mapping = aes(x= Age_Group, y = Percentage_of_Deaths)) +
  scale_y_continuous(labels = scales::percent) +
  ggtitle("Percentage of COVID-19 Deaths by Age Group in King County") +
  labs(x = "Age Group", y = "Percentage of Deaths")
