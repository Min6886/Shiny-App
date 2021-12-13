#ui.r
library(shiny)

# shinyUI(fluidPage(
#   titlePanel("title panel"),
#   sidebarLayout(
#     sidebarPanel( "sidebar panel"),
#     mainPanel("main panel")
#   )
# ))


shinyUI(fluidPage(
  titlePanel("Explore the House Price in the Boston Market "),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1','choose CSV File',
                accept = c('text/csv','text/comma-separated - values, text/plain',
                           '.csv')),
      tags$hr(),
      checkboxInput('header','Header',TRUE),
      selectInput('sep','Separator',c(Comma=',',Semicolon = ';',Tab = '\t'), ','),
      radioButtons('quote','Quote',c(None = "", 'Double Quote'='"','Single Quote'="'" ),""),
       
       # Show a plot of the generated distribution       
    
    
      helpText("Check"),
      checkboxInput("gg","Linear regression",F),
      checkboxInput("ver", "std.error",F),
      selectInput("dist","regression model:",
                  c("linear regression" = "jlm",
                    "multivariable linear " = "dlm")),
                
      plotOutput("plot", brush = "plot_brush"),
      tableOutput("data"),
  
      
      #PLOT scatterplot GRAPH
      
      
      selectInput("var",
                  label = "Choose a varible",
                  choices = c("CRIME"=1,"ZN"=2, "INDUS"=3,"CHAS"=4,"NOX"=5,"RM"=6,"AGE"=7,
                              "DIS"=8,"RAD"=9,"TAX"=10,"PTRATIO"=11, "LSTAT"=12,"MEDV" = 13,"CAT.METV" = 14
                              ),
                  selected = 1)
      
    ),

    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("dataset",tableOutput("contents")),
                  tabPanel("table",tableOutput("table")),
                  tabPanel("summary",verbatimTextOutput("summary")),
                  tabPanel("scatterplot", plotOutput("density")),
                  tabPanel("boxplot",plotOutput("boxplot")),
                  tabPanel("histogram",plotOutput("histogram"))
                  
                  
                  
                  
      
                             
      )
    )
  )
))








