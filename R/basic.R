
library(shiny)

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
  
  ## file
  fileInput("upload", NULL),
  
  ## Action button
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail"))
  
)


server <- function(input, output, session) {
  
  
}

shinyApp(ui, server)