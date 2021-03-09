<<<<<<< HEAD
library(ggplot2)          # in each relevant script
=======
library(ggplot2)       
>>>>>>> 35d36aab1b9b0a07bc0b138909060d331e5f4f3d
library(dplyr)
library(tidyverse)
library(plotly)

<<<<<<< HEAD
restaurants <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/Restaurants_Operating_during_COVID19.csv")
emergency <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/COVID_Emergency_Food_and_Meals_Seattle_and_King_County.csv")
=======
restaurants <- 
  read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/Restaurants_Operating_during_COVID19.csv")
emergency <- 
  read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/COVID_Emergency_Food_and_Meals_Seattle_and_King_County.csv")
>>>>>>> 35d36aab1b9b0a07bc0b138909060d331e5f4f3d

# Analyzing the break down for each communities that the emergency food resources serve
emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Who.They.Serve) %>%
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

youth_percent <- round((youth_num / total_open) * 100)

public_num <- emergency %>%
  filter(Public) %>%
  nrow()

public_percent <- round((public_num / total_open) * 100)

older_num <- emergency %>%
  filter(Older) %>%
  nrow()

older_percent <- round((older_num / total_open) * 100)

students_num <- emergency %>%
  filter(Students) %>%
  nrow()

students_percent <- round((students_num / total_open) * 100)

other_num <- emergency %>%
  filter(Other) %>%
  nrow()

other_percent <- round((other_num / total_open) * 100)

data <- data.frame(
  Communities = c("Youth", "Older", "Students", "Public", "Other"),
  value = c(youth_percent, 
            older_percent, 
            students_percent, 
            public_percent, 
            other_percent)) %>%
  arrange(desc(Communities)) %>%
  mutate(lab.ypos = cumsum(value) - 0.5 * value,
         label = value)

# plot pie chart
piechart <- ggplot(data, aes(x = "", y = value, fill = Communities)) +
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start = 0) +
  geom_text(aes(y = lab.ypos, label = label, x = 1.2)) +
  ggtitle("Breakdown of Communities Served (Operating Emergency Food Resources)") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylab("Percentage of Emergency Food Resources Open (%)") +
  theme(legend.title = element_text(size = 12, face = "bold"))
<<<<<<< HEAD
plot(piechart)
=======
>>>>>>> 35d36aab1b9b0a07bc0b138909060d331e5f4f3d
