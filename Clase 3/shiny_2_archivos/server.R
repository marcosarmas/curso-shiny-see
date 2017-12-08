library(shiny)

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