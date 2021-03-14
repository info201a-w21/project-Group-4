library(ggplot2)        
library(ggplot2)       
library(dplyr)
library(tidyverse)
library(plotly)

restaurants <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/Restaurants_Operating_during_COVID19.csv")
emergency <- read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/COVID_Emergency_Food_and_Meals_Seattle_and_King_County.csv")
restaurants <- 
  read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/Restaurants_Operating_during_COVID19.csv")
emergency <- 
  read.csv("https://raw.githubusercontent.com/info201a-w21/project-Group-4/main/data/COVID_Emergency_Food_and_Meals_Seattle_and_King_County.csv")

# Analyzing the break down for each communities that the emergency food resources serve
emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Who.They.Serve) %>%
  mutate(Youth = Who.They.Serve == "Youth and Young Adults", 
         Public = Who.They.Serve == "General Public",
         Older = Who.They.Serve == "Older Adults 60+ and Eligible Participants",
         Students = Who.They.Serve == "Seattle Public School Students",
         Other = Who.They.Serve == "Contact Agency for Any Eligibility Requirements")

emergency <- emergency %>%
  filter(Operational.Status == "Open") %>%
  group_by(Food.Resource.Type) %>%
  mutate(FoodBank = Food.Resource.Type == "Food Bank", 
         FoodBankandMeal = Food.Resource.Type == "Food Bank & Meal",
         Meal = Food.Resource.Type == "Meal",
         StudentToGoMeals = Food.Resource.Type == "Student To-Go Meals")

# The total numbers of emergency food resources open
total_open <- emergency %>%
  filter(Operational.Status == "Open") %>%
  nrow()

# Calculate the percentages of each communities
FoodBank_num <- emergency %>%
  filter(FoodBank) %>%
  nrow() 

FoodBank_percent <- round((FoodBank_num / total_open) * 100)

# Calculate the percentages of each communities
FoodBankandMeal_num <- emergency %>%
  filter(FoodBankandMeal) %>%
  nrow() 

FoodBankandMeal_percent <- round((FoodBankandMeal_num / total_open) * 100)

# Calculate the percentages of each communities
Meal_num <- emergency %>%
  filter(Meal) %>%
  nrow() 

Meal_percent <- round((Meal_num / total_open) * 100)

# Calculate the percentages of each communities
StudentToGoMeals_num <- emergency %>%
  filter(Youth) %>%
  nrow() 

StudentToGoMeals_percent <- round((StudentToGoMeals_num / total_open) * 100)

data <- data.frame(
  Type = c("Food Bank", "Food Bank and Meal", "Meal", "Student To Go Meals"),
  value = c(FoodBank_percent,
            FoodBankandMeal_percent,
            Meal_percent,
            StudentToGoMeals_percent))

ResourcesBreakDown <- plot_ly(data, labels = ~Type, values = ~value, type = 'pie')
ResourcesBreakDown <- ResourcesBreakDown %>% layout(title = 'Breakdown of Types of Emergency Food Resources',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

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

data2 <- data.frame(
  Type = c("Youth", "Older", "Students", "Public", "Other"),
  value = c(youth_percent,
            older_percent,
            students_percent,
            public_percent,
            other_percent))

CommunitiesBreakDown <- plot_ly(data2, labels = ~Type, values = ~value, type = 'pie')
CommunitiesBreakDown <- CommunitiesBreakDown %>% layout(title = 'Breakdown of Communities Served (Operating Emergency Food Resources)',
                      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
