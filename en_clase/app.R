library(shiny)

# Ejemplo clásico en shiny

# en UI declaramos la interface de usuario
ui <- fluidPage(
  
  # ingresamos un titulo
  titlePanel("Old Faithful Geyser Data"),
  
  # sidebar es una seccion de la página web que estara a la izquierda de la pantalla
  # aquí ponemos un control para el numero de agrupaciones de un histograma
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # mainpanel es la seccion  principal que estará al centro de la pantalla
    # aqui pondremos los graficos o productos de datos principales de nuestra visualización
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# La parte del server contiene la lógica de la programación, 
# aquí pondremos que se va a graficar y si es necesario una transformación de datos
# tiene que estar aquí

# recibe dos parámetros
# input: todos los componenetes de entrada, ejemplo: una lista de selección
# output: todos los componentes de salida donde vamos a escribir o graficar
server <- function(input, output) {
  
  # la variable output contendra todas las variables que definimos en el UI
  # en este caso vamos a dibujar un histograma
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# Escencial para cuando utilizamos un solo archivo.
shinyApp(ui = ui, server = server)