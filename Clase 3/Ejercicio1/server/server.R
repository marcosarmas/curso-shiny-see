library(shiny)
library(highcharter)

function(input, output) {
  
  archivo <- reactive({
    read.csv("./2015_AccidentesTránsitoBDD.csv")
  })
  
  output$txtZona <- renderText({ paste(c("Usted seleccionó: ",input$zona)) })
  
  output$tableAccidentes <- renderTable({
    
    datos <- archivo()
    datos[datos$ZONA == input$zona,]
    
  })
  
  output$plotSomething <- renderPlot({
    datos <- archivo()
    
    datos <- datos[datos$ZONA == input$zona,]
    
    provincias <- aggregate(NUM_FALLECIDO ~ PROVINCIA, datos, sum)
    
    par(las = 2)
    par(mar = c(5,4,8,2))
    barplot(provincias$NUM_FALLECIDO, 
            main = "Numero de fallecidos por provincia",
            names.arg =  provincias$PROVINCIA, 
            horiz = T, 
            cex.names = 0.8)
    
    
  })
  
  output$hcontainer <- renderHighchart({
    
    datos <- archivo()
    
    datos <- datos[datos$ZONA == input$zona,]
    
    provincias <- aggregate(NUM_FALLECIDO ~ PROVINCIA, datos, sum)
    
    provincias <- provincias[order(-provincias$NUM_FALLECIDO),]
    
    highchart() %>%
      hc_title(text="Número de fallecidos por provincia")%>%
      hc_chart(type="bar") %>%
      hc_xAxis(categories = provincias$PROVINCIA) %>%
      hc_add_series(provincias$NUM_FALLECIDO, name="Fallecidos") 
    
  })
}