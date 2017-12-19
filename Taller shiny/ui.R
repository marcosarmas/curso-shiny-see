library(shiny)
library(highcharter)

fluidPage(
  #título
  titlePanel("Mi primera Shiny App"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numInput", "Ingresa un número:", value = 7, min = 1, max = 30),
      dateInput("fechaEntrada", "Ingrese una fecha:", value = "2017-01-01"),
      sliderInput("numeroEntrada", "Cantidad", value=10, min=0, max=100, step = 5),
      checkboxInput("activarMagia", "Activar la magia"),
      checkboxGroupInput("regiones","Regiones", choices = list("Costa"=1,"Sierra"=2,"Amazonia"=3,"Galapagos"=4)),
      selectInput("zona","Elija una zona: ", choices = list("URBANA","RURAL", "TODOS"))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Gráfico Sencillo",
          textOutput("texto"),
          plotOutput("grafico1")
        ),
        tabPanel(
          "Gráfico Highcharter",
          highchartOutput("grafico2")
        ),
        tabPanel(
          "Resumen",
          verbatimTextOutput("resumen")
        )
      )
    )
  )
)
