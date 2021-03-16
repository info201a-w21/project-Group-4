library(shiny)
library(countrycode)
source("bargraph.R")
source("PieChart.R")

intro <- tabPanel("Food Accessibility",
  titlePanel("Food Accessibility in King County, WA during COVID-19 Pandemic"),
  h4("By Abbie Sawyer, Annie Tu, Bruce Chen, Christine Nguyen"),
  br(),
  img("", src = "https://crosscut.com/sites/default/files/styles/max_992x992/public/images/articles/200820_de_communityfridge_hero_teaser.jpg.jpg?itok=6mtc8jtm",
      height = "50%", width = "50%"),
  br(), 
  br(),
  p("Another year into the pandemic, and the world is continuing to struggle with 
  issues from a year ago. Worriying if a stimulus check will come, let alone in time.
  Contemplating the state of one's mental health, exacerbated by isolation 
  and social distancing. Grappling with the reality that one might not be able to 
  buy groceries until next week.", strong("This is a reality for many people, 
                                          at home and abroad.")),
  br(),
  p("Food accessibility has become a major concern for people during the pandemic, 
    even more so than ever before. Due to rising unemployment and public regulation policies,
    the stability people may have experienced previously with food has undoubtedly changed.
    We wanted to investigate the relationship between COVID-19, the number of
    operating restaurants, and emergency food resources, to discover
    how much of an effect the pandemic has had on people’s ability to access food,
    specifically in King County. This will give us a better understanding of the situation,
    which can help both our own communities as well as others moving forward."),
  br(),
  p("Within this project, we will showcasing three interactive visualizations
    that will allow you to develop a nuanced understanding of food access in King County
    during the last year or so."),
  br(),
  p(strong("Specific questions we wanted to answer:")),
  p(em("Is there a correlation between the number of COVID cases and the number 
       of operating restaurants in King County?")),
  p(em("Does food accessibility (emergency or in general) have an impact on 
           the increase or decrease of COVID-19 cases in King County?")),
  p(em("Is there a correlation between the number of operating restaurants and 
       the accessibility to emergency food resources?")),
  br(), 
  p("Our datasets come from data.gov, data.seattle.gov, and kingcounty.gov. They contain data on
  Emergency Food & Meals locations in Seattle and King County, restaurants that are still operating 
  during the pandemic, and COVID-19 cases and death tolls in King County."),
  br(),
  p(em("The photo featured above is of a community fridge/food pantry located in 
  the South Park neighborhood in south King County. These fridges provide free food
  and enable disadvantaged communities to access the nourishment they need."))
)

interactive_one <- tabPanel(
  "Bar Graph",
  selectInput(
    inputId = "city",
    label = "Choose a city",
    choices = cities,
  ),
  plotlyOutput("interactive_bar")
)

interactive_two <- tabPanel(
  "Pie Chart",
  selectInput(
    inputId = "figure",
    label = "Choose a set of data frame to examine",
    choices = c("Resources BreakDown", "Communities BreakDown")
  ),
  plotlyOutput("Pie")
)

interactive_three <- tabPanel(
  "Map",
  selectInput(inputId = "map_data",
              label = "Choose a data to examine.",
              choices =  c("Number of Food Sources" = "num_food_sources",
                           "Highest Population" = "Positives",
                           "Highest Deaths" = "Deaths",
                           "Deaths Per Food Source" = "deaths_per_fs",
                           "Positive Tests Per Food Source" = "positives_per_fs")),
  plotlyOutput("interactive_map"),
  p("This map further shows relevant data for food supply and Covid deaths and 
  positive tests and attempts to create a comparable metric to analyze across 
  most cities in King County. In doing this the goal is to find areas in King 
  County that may not have adequate support in supplying food to its community.
  ")
)

conclusion <- tabPanel(
  "Conclusions",
  titlePanel("Project Reflections and Moving Forward"),
  br(),
  img("", src = "https://cdn.vox-cdn.com/thumbor/mU29W0ANw5NGxeqWb4GMFSS0mhE=/0x0:4463x2992/1200x675/filters:focal(909x653:1623x1367)/cdn.vox-cdn.com/uploads/chorus_image/image/61676585/Food_Bank__4_of_6_.0.jpg",
      height = "60%", width = "50%"),
  br(),
  br(),
  p("As we continue through another year of the pandemic, it's important we deeply consider
  the challenges our community faces and what we can do to mitigate those struggles. 
  As you can see through our interactive pieces, the distribution of food access points is 
  uneven, and that leaves certain communities, often lower in income and higher in 
  diversity, with less resources to sustain themselves."),
  br(),
  p("With the trends and takeaways this project has illuminated, we hope to 
    encourage our audiences to step back and reflect on the severity of the situation. 
    Not everyone can donate time and/or food, but it's important to distribute resources, 
    whenever we can. Whether it be information or support programs, we must circulate it,
    in hopes it will reach the right people. We are beginning to see the 
    light at the end of the tunnel, with vaccines being distributed, but food accessibility
    will remain a pressing issue after it is over. Please continue sharing locations of 
    community fridges, free food trucks, food banks, and other resources to help 
    folks get through the pandemic."),
  br(),
  p("Through the pie chart analysis of the types of food resources offered and the different communities
    being served in King County. We noticed that the general younger population such as students and 
    young adults have abundant of food resources to access during this pandemic. However, it was concerning
    to see that the elderly population was the most underserved community and had less emergency food recource
    access than the rest. The elderly community is considered as a high risk community during the pandemic,
    they should be prioritized to be served in this extreme times, the data suggests otherwise. We should have more 
    available food resources for the elderly to access during the pandemic."),
  br(),
  p(strong("Insert Annie's Takeway")),
  br(),
  p("Through the map it is noticeable that areas outside the center of Seattle had a much higher 
    death to number of food sources rate. Also there seems to be a lack of food sources outside 
    the center city which is concerning. Food is a necessity to life and in areas where there are 
    more people who rely on free food, even not because of Covid-19, there is not enough of it. 
    This shows that a lot of the emergency food is misallocated in King County and is a problem 
    that needs to be addressed."),
  br(),
  p(em("The featured photo is of local community members at the White Center Food Bank.
           This food bank is 40 years old and serves an unincorporated neighborhood 
           in south King County, home to many BIPOC communities and new immigrants. 
           Food banks have been an incredible place of support for vulnerable communities,
           especially during these times."))
  
)

ui <- navbarPage(
  "Info 201 AD - Final Deliverable", 
  intro,        
  interactive_one,
  interactive_two,
  interactive_three,
  conclusion
)
