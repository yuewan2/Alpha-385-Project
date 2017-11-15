library(shiny)
library(ggplot2)

Home_Guest_Visual = read.csv("Home_Guest_Visual.csv")

# Define UI ----
ui = shinyUI(fluidPage(
  titlePanel(h2("NBA Data Analysis")),
  
  sidebarLayout(
    sidebarPanel(
      h3("Home/Away Effects"),
      "In the world of analyzing NBA data, whether the game is played at home or away can have a", strong("huge"),
      p("impact on the actual result."),
      p("In here, you are going to select your own variable to see its difference in Home Game versus Guest Game."),
      p("You can also choose between scatterplot or barplot."),
      hr(),
      fluidRow(
        column(6,
               selectInput("var_chosen", label = "Variable", c(None = '.', names(Home_Guest_Visual)[4:27]))      
        )
      ),
      radioButtons(inputId="choice", label="What would you like to see?", 
                   choices=c("Scatterplot","Barplot"))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Main", plotOutput("plot")),
        tabPanel("Dictionary", 
                p(strong("W"), "- The number of Wins"),
                p(strong("L"), "- The number of losses")
                 
        ),
        tabPanel("About", textOutput("about"))
      )
    )
  ) 
))

# Define server logic ----
server = shinyServer(function(input, output) {
  #active_graph = reactive({
  #  if(input$var_chosen == "W"){
  #    ggplot(Home_Guest_Visual) + geom_bar(aes(TEAM, W, fill = HOME_GUEST), position="dodge",stat="identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))
  #  }
  #})
  
  output$plot = renderPlot({
    ggplot(Home_Guest_Visual) + geom_bar(aes(TEAM, WIN_Ratio, fill = HOME_GUEST), position="dodge",stat="identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))
  })
  
  
})

# Run the app ----
shinyApp(ui = ui, server = server)