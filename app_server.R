source("bargraph.R")

server <- function(input, output) {
  # not finished
  output$interactive_bar <- renderPlotly({
    the_city <- by_city %>% 
      filter(City == input$city)
    new_bar_graph <- ggplot(data = the_city) +
      geom_col(mapping = aes(x = Age_Group, y = ratio))
    ggplotly(new_bar_graph)
  })
  
}