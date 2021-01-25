
library(shiny)

ui <- fluidPage(
  column(6, plotOutput("plot")),
  column(6, plotOutput("plot2"))
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot(plot(1:5), res = 96)
  output$plot2 <- renderPlot(plot(1:5), res = 96)
}

shinyApp(ui, server)