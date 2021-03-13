# load packages
library(tidyverse)
library(plotly)
library(shiny)


source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)