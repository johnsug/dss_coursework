
# initiate server for the Shiny app
shinyServer(function(input, output) {
    
  # allow data to react to drop-down selections
  data <- reactive({
    d[d$Industry == input$Industry,]})
  
  # lookup mortality rate
  output$mortalityRate <- renderText({
    paste0("Projected annual mortality rate: ", 
           round(d$Mortality[d$Gender == input$Gender & d$Industry == input$Industry & d$Age == input$Age]*100,3),"%")})
  
  # generate mortality chart
  output$mortalityPlot <- renderPlot({
    ggplot(data(), aes(x=Age, y=Mortality, color=Gender)) + geom_line(size=1.5) + 
      labs(y="Mortality Rate", title="Mortality Rate by Industry and Gender")})  
})
