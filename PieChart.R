install.packages("ggplot2") # once per machine
library("ggplot2")          # in each relevant script
library(dplyr)
library(tidyverse)

restaurants <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/Restaurants_Operating_during_COVID19.csv")
View(restaurants)
emergency <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/COVID_Emergency_Food_and_Meals_Seattle_and_King_County.csv")
View(emergency)

# Analyzing the break down for each communities that the emergency food resources serve
emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Who.They.Serve)%>%
  mutate(Youth = Who.They.Serve == "Youth and Young Adults", 
         Public = Who.They.Serve == "General Public",
         Older = Who.They.Serve == "Older Adults 60+ and Eligible Participants",
         Students = Who.They.Serve == "Seattle Public School Students",
         Other = Who.They.Serve == "Contact Agency for Any Eligibility Requirements")

# The total numbers of emergency food resources open
total_open <- emergency %>%
  filter(Operational.Status == "Open") %>%
  nrow()

# Calculate the percentages of each communities
youth_num <- emergency %>%
  filter(Youth) %>%
  nrow() 

youth_percent <- (youth_num / total_open) * 100

public_num <- emergency %>%
  filter(Public) %>%
  nrow()

public_percent <- (public_num / total_open) * 100

older_num <- emergency %>%
  filter(Older) %>%
  nrow()

older_percent <- (older_num / total_open) * 100

students_num <- emergency %>%
  filter(Students) %>%
  nrow()

students_percent <- (students_num / total_open) * 100
 
other_num <- emergency %>%
  filter(Other) %>%
  nrow()

other_percent <- (other_num / total_open) * 100

data <- data.frame(
  Communities= c("Youth","Older","Students","Public","Other"),
  value=c(youth_percent,older_percent,students_percent,public_percent,other_percent),
  mutate(Group = factor(Group, levels = c("Neutral", "Negative", "Positive")),
         cumulative = cumsum(value),
         midpoint = cumulative - value / 2,
         label = paste0(Group, " ", round(value / sum(value) * 100, 1), "%"))
)

# plot pie chart
ggplot(data, aes(x="", y=value, fill=Communities))+
  geom_bar(width = 1, position = "stack") + 
  coord_polar(theta = "y") +
  geom_text(aes(x = 1.3, y = midpoint, label = label)) +
  ggtitle("Breakdown of Communities Served (Operating Emergency Food Resources)") +
  ylab("Percentage of Emergency Food Resources Open")