
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(highcharter)

shinyServer(function(input, output, session) {

  getData <- reactive({
    nacidos <- read.csv("./ENV_2016.csv")
    provincias <- split(levels(nacidos$prov_nac), levels(nacidos$prov_nac))
    updateSelectizeInput(session,"provincias",choices = provincias)
    nacidos
  })
  
  output$timeline <- renderHighchart({
    nacimientos <- getData()
    #highchart(type="stock")%>%
    #  hc_title(text = "Nacimientos")
    #  hc_add_series(nacimientos)
  })
  
})
