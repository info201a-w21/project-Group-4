library(shiny)
library(countrycode)

source("analysis.R")

intro <- tabPanel("Food Accessibility",
  titlePanel("Food Accessibility in King County, WA during COVID-19 Pandemic"),
  br(),
  img("", src = "https://api.time.com/wp-content/uploads/2020/11/Food_Banks_US_01COVID-Pandemic_.jpg?w=824&quality=70"),
  br(), 
  p("Another year into the pandemic, and the world is continuing to struggle with 
  issues from a year ago. Worries about if a stimulus check will come, let alone in time.
  Contemplating the state of one's mental health, exascerbated by isolation 
  and social distancing. 
  Food accessibility has become a major concern for people during the pandemic, 
    even more so than ever before. Due to rising unemployment and public regulation policies,
    the stability people may have experienced previously with food has undoubtedly changed.
    We wanted to investigate the relationship between COVID-19, the number of
    operating restaurants, and emergency food resources, to discover
    how much of an effect the pandemic has had on people’s ability to access food,
    specifically in King County. This will give us a better understanding of the situation,
    which can help both our own communities as well as others moving forward."),
  br(),
  p("Our datasets come from data.gov, data.seattle.gov, and kingcounty.gov. They contain data on
  Emergency Food & Meals locations in Seattle and King County, restaurants still open during
  COVID-19, and COVID-19 data in King County."),
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
