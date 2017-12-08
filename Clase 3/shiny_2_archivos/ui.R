library(shiny)
fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(HTML('<p>
                      <label>A numeric input:</label><br /> 
                      <input type="number" name="n" value="7" min="1" max="30" />
                      </p>')),
    mainPanel(
      p(strong("bold font "), em("italic font")),
      p(code("code block")),
      a(href="http://www.google.com", "link to Google"))
    )
  )