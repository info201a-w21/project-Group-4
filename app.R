# load packages
library(tidyverse)
library(plotly)
library(ggplot2)
library(shiny)
library(mapproj)

source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)