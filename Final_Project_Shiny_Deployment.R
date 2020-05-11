library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(ggplot2)
library(highcharter)
library(lubridate)
library(stringr)
library(withr)
library(treemap)
library(DT)
library(shinyBS)
library(shinyjs)
library(WDI)
library(geosphere)
library(magrittr)
library(shinycssloaders)
library(timevis)
library(shinythemes)

linegraphdf <- read.csv("examplelinegraphforshiny.csv")
exampleshoppers <- read.csv("exampleshoppersforshiny.csv")

ui <- fluidPage(
    
    # App title ----
    titlePanel("Online Shopper's Prediction & Significant Website Metrics"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            dateRangeInput('dateRange',
                       label = 'Date range input:',
                       start = Sys.Date() - 7, end = Sys.Date()
            ),
            
            actionButton("update", "Update View")
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Tabset w/ plot, summary, and table ----
            tabsetPanel(type = "tabs",
                        tabPanel("Website Metric", plotOutput("plot")),
                        tabPanel("List of visitors", tableOutput("table"))
            )
            
        )
    )
)
    
server <- function(input, output) {
    
    output$plot <- renderPlot({
        
        ggplot(linegraphdf, aes(x=Day, y=Rates, group=Type)) + geom_line(aes(color=Type)) + geom_point(aes(color=Type))
        
    })
    
    # Generate an HTML table view of the data ----
    output$table <- renderTable({
        head(exampleshoppers,112)
    })
    
}
    
shinyApp(ui, server)