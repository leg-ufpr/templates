library(shiny)
library(shinydashboard)

ui <- dashboardPage(
    dashboardHeader(),
    dashboardSidebar(
        tags$img(src = "https://i.imgur.com/hYfF8SK.png", height = "220",
                 width = "220")
    ),
    dashboardBody(
        includeCSS("legtemplate.css")
))

server <- function(input, output) {}
