
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(highcharter)

shinyUI(fluidPage(

  navbarPage("R USER GROUP",
             tabPanel("Estadisticas Descriptivas",
                      sidebarLayout(
                        sidebarPanel(
                          selectizeInput("provincias","Seleccione una provincia",choices=list("Azuay","Bolívar","Cañar","Carchi","Chimborazo","Cotopaxi","El Oro","Esmeraldas","Galápagos","Guayas","Imbabura","Loja","Los Ríos","Manabí","Morona Santiago","Napo","Orellana","Pastaza","Pichincha","Santa Elena","Santo Domingo de los Tsáchilas","Sucumbíos","Tungurahua","Zamora Chinchipe","Zonas no delimitadas"), multiple=T),
                          checkboxGroupInput("genero","Genero", choices = list("Hombre","Mujer"),selected = list("Hombre","Mujer"))
                        ),
                        mainPanel(
                          highchartOutput("nacidosProvincia",height = 800)
                        )
                      )
                      ),
             tabPanel("Serie de tiempo", 
                      fluidRow(
                        column(12,
                               highchartOutput("serieTiempo"))
                      ),
                      fluidRow(
                        column(4,
                               dateRangeInput("rangoFechas", 
                                              label = "Seleccione un rango de fechas", 
                                              start = "2016-01-01",
                                              end = "2016-12-31"
                                              )
                                        
                               ),
                        column(4,
                               tableOutput("tipoParto")
                               ),
                        column(4,
                               highchartOutput("area",width = 400)
                               )
                      )
                      ),
             tabPanel("Scatter plot", "hola mundo 3")
  )

))
