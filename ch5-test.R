library(shiny)
library(tidyverse)
library(vroom)

## Download tables from https://github.com/hadley/mastering-shiny/tree/master/neiss
injuries <- vroom::vroom("neiss/injuries.tsv.gz")
products   <- vroom::vroom("https://raw.githubusercontent.com/hadley/mastering-shiny/master/neiss/products.tsv")
population <- vroom::vroom("https://raw.githubusercontent.com/hadley/mastering-shiny/master/neiss/population.tsv")

## functions
count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump_n(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}

## App
ui <- fluidPage(
  fluidRow(
    column(8,
           selectInput("code", "Product",
                       choices = setNames(products$prod_code, products$title),
                       width = "100%"
           )
    ),
    column(2, selectInput("y", "Y axis", c("rate", "count"))),
    column(2, numericInput("n", "Number of rows", value = 5, min = 1, max = 10)),
    
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  ),
  fluidRow(
    column(2, actionButton("story", "Tell me a story")),
    column(10, textOutput("narrative"))
  )
)

server <- function(input, output, session) {
  
  selected <- reactive(injuries %>% filter(prod_code == input$code))
  
  output$diag      <- renderTable(count_top(selected(), diag     , n = input$n), width = "100%")
  output$body_part <- renderTable(count_top(selected(), body_part, n = input$n), width = "100%")
  output$location  <- renderTable(count_top(selected(), location , n = input$n), width = "100%")

  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })
  
  output$age_sex <- renderPlot({
    if (input$y == "count") {
      summary() %>%
        ggplot(aes(age, n, colour = sex)) +
        geom_line() +
        labs(y = "Estimated number of injuries")
    } else {
      summary() %>%
        ggplot(aes(age, rate, colour = sex)) +
        geom_line(na.rm = TRUE) +
        labs(y = "Injuries per 10,000 people")
    }
  }, res = 96)
  
  output$narrative <- renderText({
    input$story
    selected() %>% pull(narrative) %>% sample(1)
  })
  
}

shinyApp(ui, server)

