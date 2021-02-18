# Bar graph of deaths by age group in King County

library(tidyverse)
age_data <- read.csv(paste(getwd(), "/data/nts-by-date-all-demographics-jan-19.csv", sep = ""))

age_data <- age_data %>% 
  group_by(Age_Group) %>% 
  mutate(Total = Population - Deaths)

columns <- age_data %>% 
  select(Age_Group, Deaths, Total, Population) %>% 
  gather(key = Deaths, value = Population, -Age_Group, -Population)


ggplot(columns) +
  geom_col(mapping = aes(x = Age_Group, y = Population, fill = Deaths))
  #geom_col(aes(fill = Deaths))
  
#  geom_col(mapping = aes(x = Age_Group, y = Population, fill = "Deaths"))
  #geom_bar(position = "stack", stat = "identity")
# , aes (x = Age_Group, y = Population, fill = Population)
                 
 