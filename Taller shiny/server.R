
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(highcharter)

function(input, output) {

    output$texto <- renderText({
      paste("Usted seleccionó: ", input$zona)
    })
  
    datos <- reactive({
      archivo <- read.csv("./2015_AccidentesTransitoBDD.csv")
      if (input$zona != "TODOS"){
        archivo <- archivo[archivo$ZONA == input$zona, ]
      }
      
      archivo
    })
    
    output$grafico1 <- renderPlot({
      accidentes <- datos()
      provincias <- aggregate(NUM_FALLECIDO ~ PROVINCIA, accidentes, sum)
      barplot(provincias$NUM_FALLECIDO, 
              main = "Numero de fallecidos por provincia",
              names.arg =  provincias$PROVINCIA, 
              horiz = T, 
              cex.names = 0.8)
    })
    
    output$grafico2 <- renderHighchart({
      accidentes <- datos()
      causas <- aggregate(TOTAL_VICTIMAS ~ CAUSA, accidentes, sum)
      hchart(causas,"column",hcaes(x=CAUSA, y=TOTAL_VICTIMAS))
    })
    
    output$resumen <- renderPrint({
      summary(datos())
    })

}
