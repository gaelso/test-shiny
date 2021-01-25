
library(shiny)
library(tidyverse)
library(lubridate)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")

ui <- fluidPage(
  ## text
  textInput("name", "What's your name?"),
  textInput("name2", label= NULL, placeholder = "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3),
  
  ## numeric
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100),
  sliderInput("ex", "When should we deliv?", value = ymd("2020-09-17"), min = ymd("2020-09-16"), max = ymd("2020-09-23"), timeFormat = "%F"),
  sliderInput("ex2", "Select a value:", value = 0, min = 0, max = 100, step = 5, animate = TRUE),
  numericInput("number", "Select a value", value = 150, min = 0, max = 1000, step = 50), ## Step defines the interval between each value when using top/bottom arrows
  
  ## dates
  dateInput("dob", "When were you born?"),
  dateRangeInput("holiday", "When do you want to go on vacation next?"),
  
  ## limited choices
  selectInput("state", "What's your favourite state?", state.name),
  radioButtons("animal", "What's your favourite animal?", animals),
  radioButtons(
    "rb", "Choose one:",
    choiceNames = list(
      icon("angry"),
      icon("smile"),
      icon("sad-tear")
    ),
    choiceValues = list("angry", "happy", "sad")
  ),
  selectInput(
    "state2", "What's your favourite state?", state.name,
    multiple = TRUE
  ),
  checkboxGroupInput("animal2", "What animals do you like?", animals),
  selectInput(
    "state3", "Choose a state:",
    list(`East Coast` = list("NY", "NJ", "CT"),
         `West Coast` = list("WA", "OR", "CA"),
         `Midwest` = list("MN", "WI", "IA"))
  ),
  
  ## file
  fileInput("upload", NULL),
  
  ## Action button
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionButton("drink", "Drink me!", class = "btn-lg btn-success")
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block")
  ),
  
  ## Output text
  textOutput("text"),
  verbatimTextOutput("code"),
  
  ## Table output
  tableOutput("static"),
  dataTableOutput("dynamic"),
  dataTableOutput("dynamic2"),
  
  ## Plot output
  plotOutput("plot", width = "400px")
  
)


server <- function(input, output, session) {
  
  ## Output text
  output$text <- renderText({ 
    input$name2
  })
  output$code <- renderPrint({ 
    summary(1:10) 
  })
  
  ## Output table
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
  output$dynamic2 <- renderDataTable(
    mtcars, 
    options = list(
      pageLength = 5,
      ordering = FALSE, 
      searching = FALSE
      )
    )
  
  ## Output plot
  output$plot <- renderPlot(plot(1:5), res = 96)
  
}

shinyApp(ui, server)