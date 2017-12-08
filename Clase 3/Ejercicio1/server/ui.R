library(shiny)
library(highcharter)

fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      selectInput("zona", "Elija una Zona", c("Urbana"="URBANA","Rural"="RURAL"))
    ),
    mainPanel(
      textOutput("txtZona"),
      tabsetPanel(
        
        tabPanel(
          "Table Output",
          tableOutput("tableAccidentes")
        ),
        tabPanel(
          "Plot Output",
          plotOutput("plotSomething")
        ),
        tabPanel(
          "High Charter",
          highchartOutput("hcontainer",height = "500px")
        )
      )
    )
  )
)