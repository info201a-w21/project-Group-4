library(shiny)
library(countrycode)

source("analysis.R")

intro <- tabPanel("Food Accessibility",
  titlePanel("Food Accessibility in King County, WA during COVID-19 Pandemic"),
  br(),
  
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
