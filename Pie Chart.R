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
  mutate(youth = Who.They.Serve == "Youth and Young Adults")

emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Who.They.Serve)%>%
  mutate(public = Who.They.Serve == "General Public")

emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Who.They.Serve)%>%
  mutate(older = Who.They.Serve == "Older Adults 60+ and Eligible Participants")

emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Who.They.Serve)%>%
  mutate(students = Who.They.Serve == "Seattle Public School Students")

emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Who.They.Serve)%>%
  mutate(other = Who.They.Serve == "Contact Agency for Any Eligibility Requirements")

youth_num <- emergency %>%
  filter(youth) %>%
  nrow()

public_num <- emergency %>%
  filter(public) %>%
  nrow()

older_num <- emergency %>%
  filter(older) %>%
  nrow()

students_num <- emergency %>%
  filter(students) %>%
  nrow()
  
other_num <- emergency %>%
  filter(other) %>%
  nrow()

data <- data.frame(
  group= c("youth","older","students","public","other"),
  value=c(youth_num,older_num,students_num,public_num,other_num)
)

# plot pie chart
ggplot(data, aes(x="", y=value, fill=group))+
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start=0) + 
  ggtitle("Communities") +
  xlab("Communities") + ylab("Number of Emergency Food Resources Open")