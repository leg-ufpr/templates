library(shiny)
library(shinydashboard)

#-------------------------------------------------------------------------------
ui <- dashboardPage(
    dashboardHeader(),
    dashboardSidebar(
        tags$img(src = "https://i.imgur.com/hYfF8SK.png", height = "220",
                 width = "220"), hr(),
        actionButton("exit", "Exit")
    ), # End sidebar
    dashboardBody(
        includeCSS("legtemplate.css")
    ) # End Body
) # End Page

#-------------------------------------------------------------------------------
server <- function(input, output) {
    observeEvent(input$exit, {stopApp()})
}

shinyApp(ui, server)
