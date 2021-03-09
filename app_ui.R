library(shiny)
library(countrycode)

source("analysis.R")

intro <- tabPanel(
  "Introduction"
)

interactive_one <- tabPanel(
  "Data"
)

interactive_two <- tabPanel(
  "Data"
)

interactive_three <- tabPanel(
  "Data"
)

conclusion <- tabPanel(
  "Conclusion"
)

ui <- navbarPage(
  "Title", 
  intro,        
  interactive_one,
  interactive_two,
  interactive_three,
  conclusion
)
