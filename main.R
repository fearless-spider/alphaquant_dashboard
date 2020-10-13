# Title     : AlphaQuant Dashboard
# Objective : Interactive dashboard
# Created by: Przemyslaw Pajak
# Created on: 24/08/2020
#install.packages("httr")

#Require the package so you can use it
require("httr")
#install.packages("jsonlite")

#Require the package so you can use it
require("jsonlite")
library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(

# App title ----
titlePanel("AlphaQuant Dashboard"),

# Sidebar layout with input and output definitions ----
sidebarLayout(

# Sidebar panel for inputs ----
sidebarPanel(

# Input: Slider for the number of bins ----
h3("Stop Loss settings"),
sliderInput(inputId = "avgTKB",
            label = "Average Length between Kijun and Tenkan and Senkou:",
            min = 1,
            max = 50,
            value = 30),

hr(),
h3("Ichimoku Kinko Hyo settings"),

sliderInput(inputId = "Tenkan",
            label = "Tenkan:",
            min = 1,
            max = 50,
            value = 9),

sliderInput(inputId = "Kijun",
            label = "Kijun:",
            min = 1,
            max = 100,
            value = 26),

sliderInput(inputId = "Senkou",
            label = "Senkou:",
            min = 1,
            max = 200,
            value = 52),

hr(),
h3("Open position"),

sliderInput(inputId = "TK",
            label = "Length between Kijun and Tenkan:",
            min = 1,
            max = 50,
            value = 30),

sliderInput("Hours", "Hours range:",
            min = 1, max = 24,
            value = c(1, 6)),

hr(),
h3("Type of operation"),

checkboxInput(inputId = "Sell", label = "Sell", value = -1, width = NULL),
checkboxInput(inputId = "Buy", label = "Buy", value = 1, width = NULL),

),

# Main panel for displaying outputs ----
mainPanel(

# Output: Histogram ----
plotOutput(outputId = "distPlot")

)
)
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({

    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

  })

}

shinyApp(ui = ui, server = server)