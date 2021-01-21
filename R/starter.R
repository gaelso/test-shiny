# install.packages(c(
#   "gapminder", "ggforce", "globals", "openintro", "RSQLite", "shiny", 
#   "shinycssloaders", "shinyFeedback", "shinythemes", "testthat", 
#   "thematic", "tidyverse", "vroom", "waiter", "xml2", "zeallot" 
# ))


library(shiny)

## shinyapp shift+tab

# ui <- fluidPage(
#   "Hello, world!"
# )

# server <- function(input, output, session) {
#   
# }


ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)


server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    summary(dataset())
  })
  
  output$table <- renderTable({
    dataset()
  })
}


shinyApp(ui, server)