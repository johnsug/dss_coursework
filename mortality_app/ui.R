
# initiate UI for the shiny app
shinyUI(
  
    # define page layout
  fluidPage(
    
    titlePanel("Mortality Prediction"),
    
    # call README.md for tool documentation
    fluidRow(includeMarkdown("README.md")),
    
    # tool begins here
    fluidRow(tags$h3("Tool:")),
    
    # drop-down content
    fluidRow(
        column(3,selectInput('Industry', 'Industry:', c('All', 'White Collar', 'Blue Collar'))),
        column(3,selectInput('Gender', 'Gender:', c('Male', 'Female'))),
        column(3,selectInput('Age', 'Age:', c(18:65)))
      ),
    
    # predicted mortality rate
    fluidRow(tags$h4(textOutput("mortalityRate"))),
    
    # mortality plot
    fluidRow(plotOutput('mortalityPlot'))

))
