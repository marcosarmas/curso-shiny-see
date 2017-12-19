
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(highcharter)
shinyUI(fluidPage(

  # Application title
  titlePanel("Nacimientos en Ecuador"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectizeInput("provincias", "Provincias: ", choices=list("Todos"), multiple=T),
      tags$div(conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                                tags$div(id="loadmessageContainer",
                                         tags$div(id="loadmessage","Loading...",br(),tags$div(class="loader",""))
                                         )
                                )
               )
      
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      highcartOutput("timeline")
    )
  )
))
