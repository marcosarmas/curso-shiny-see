
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(highcharter)
library(reshape)
library(plyr)
library(xlsx)
Sys.setlocale()
shinyServer(function(input, output, session) {
  
  cargarDatos <- reactive({
    #Para leer archivo CSV
    #nacidosVivos <- read.csv("./ENV_2016.csv")
    load("./nacidos_vivos2016.RData")
    
    #convertimos factores a characters
    nacidosVivos$prov_nac <- as.character(nacidosVivos$prov_nac)
    nacidosVivos$tipo_part <- as.character(nacidosVivos$tipo_part)
  
    #encoding para utilizar tildes y otras letras  
    Encoding(nacidosVivos$prov_nac)<-"latin1"
    Encoding(nacidosVivos$tipo_part)<-"latin1"
    
    
    #filtros
    #género
    nacidosVivos <- nacidosVivos[nacidosVivos$sexo %in% input$genero,]
    
    #provincias
    if (! is.null(input$provincias)  ){
      filtro_provincia <- enc2native(as.character(input$provincias))
      nacidosVivos <- nacidosVivos[enc2utf8(nacidosVivos$prov_nac) %in% filtro_provincia,]
    }
    
    
    
    #Filtro de fechas
    
    #transformar la fecha en fecha valida
    #%m = mes
    #%d = dia
    #%y = año ej: 95
    #%Y = año ej: 1995
    nacidosVivos$fecha_nac <- as.Date(nacidosVivos$fecha_nac, format='%m/%d/%Y')
    
    #filtramos a partir del 2016
    nacidosVivos <- nacidosVivos[nacidosVivos$fecha_nac>'2016-01-01',]
    
    #aplicar filtro de fechas
    nacidosVivos <- nacidosVivos[(nacidosVivos$fecha_nac >= input$rangoFechas[1] & nacidosVivos$fecha_nac <= input$rangoFechas[2]),]
    
    #Regresar la variable con los datos 
    nacidosVivos
  })
  
  output$nacidosProvincia <- renderHighchart({
    datos <- cargarDatos()
    ps <- count(datos, c("prov_nac","sexo"))
    ps <- ps[order(ps$freq, decreasing = T ),]
    hchart(ps, "bar", hcaes(x = prov_nac, y = freq, group = sexo))
  
    
  })
  
  output$serieTiempo <- renderHighchart({
    nacidos <- cargarDatos()
    
    
    a <- count(nacidos, c("fecha_nac","sexo"))
    
    highchart()%>%
      hc_chart(type="line")%>%
      hc_title(text = "Nacimientos") %>%
      hc_xAxis(categories=a$fecha_nac)%>%
      hc_add_series(a[a$sexo=="Hombre",]$freq, name="Hombres")%>%
      hc_add_series(a[a$sexo=="Mujer",]$freq, name="Mujeres")%>%
      hc_exporting(enabled=T)
  })
  
  output$tipoParto <- renderTable({
    nacidos <- cargarDatos()
    tipo_parto <- count(nacidos, "tipo_part")
    colnames(tipo_parto) <- c("Tipo", "Cantidad")
    tipo_parto
  })
  
  output$area <- renderHighchart({
    nacidos <- cargarDatos()
    
    areas <- count(nacidos, "area_res")
    
    highchart()%>%
      hc_chart(type="pie")%>%
      hc_xAxis(categories = areas$area_res)%>%
      hc_add_series(areas$freq, name="Area", showInLegend = FALSE)
  })
  
  output$descargarCSV <- downloadHandler(
    filename = "nacidos_vivos.csv",
    content = function(file) {
      write.csv(cargarDatos(), file)
    }
  )
  
  output$descargarXLSX <- downloadHandler(
    filename = "nacidos_vivos.xlsx",
    content = function(file) {
      write.xlsx(cargarDatos(), file, sheetName="Hoja 1", col.names=TRUE, row.names=FALSE, append=FALSE)
    }
  )
  
})
