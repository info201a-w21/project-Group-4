source("bargraph.R")
source("PieChart.R")
source("map.R")

server <- function(input, output) {
  # interactive bar graph of how many people got tested compared to population
  # for each age group
  output$interactive_bar <- renderPlotly({
    the_city <- by_city %>% 
      filter(City == input$city)
    new_bar_graph <- ggplot(data = the_city) +
      geom_col(mapping = aes(x = Age_Group, y = ratio)) +
      ggtitle(paste("COVID-10 Testing Rate by Age Group in ", input$city)) +
      xlab("Age Group") +
      ylab("Testing rate")
    ggplotly(new_bar_graph)
  })
  
  # Pie Chart Server
  output$Pie <- renderPlotly({
    if (input$figure == "Resources BreakDown") {
      ResourcesBreakDown
    } else {
      CommunitiesBreakDown
    }
  })
  
  # Map 
  output$interactive_map <- renderPlotly({
    if(input$map_data == "Positives"){
      map <- positives_map
    }else if(input$map_data == "Deaths"){
      map <- deaths_map
    }else if(input$map_data == "num_food_sources"){
      map <- food_sources_map
    }else if(input$map_data == "deaths_per_fs"){
      map <- deaths_per_fs_map
    }else if(input$map_data == "positives_per_fs"){
      map <- positives_per_fs_map
    }else{
      
    }
    plotly_map <- ggplotly(map)
    plotly_map
  })
  
}