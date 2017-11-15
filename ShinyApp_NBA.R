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
                p(strong("L"), "- The number of losses"),
                p(strong("PTS"), "- Points"),
                p(strong("FGM-A"), "- Field Goals Made-Attempted"),
                p(strong("FG%"), "- Field Goal Percentage"),
                p(strong("3PM-A"), "- 3-Point Field Goals Made-Attempted"),
                p(strong("3P%"), "- 3-Point Field Goal Percentage"),
                p(strong("2PM-A"), "- 2-Point Field Goals Made-Attempted"),
                p(strong("2P%"), "- 2-Point Field Goal Percentage"),
                p(strong("FTM-A"), "- Free Throws Made-Attempted"),
                p(strong("FT%"), "- Free Throw Percentage"),
                p(strong("OR"), "- Offensive Rebounds"),
                p(strong("DR"), "- Defensive Rebounds"),
                p(strong("REB"), "- Rebounds; A rebound is a statistic awarded to a player who retrieves the ball after a missed field goal or free throw. Rebounds are also given to a player who tips in a missed shot on his team's offensive end."),
                p(strong("AST"), "- Assists; The last pass to a teammate that leads directly to a field goal and the player receiving the pass must move immediately toward the basket in a scoring motion."),
                p(strong("BLK"), "- Blocks; A block or blocked shot occurs when a defensive player legally deflects a field goal attempt from an offensive player."),
                p(strong("STL"), "- Steals; A steal occurs when a defensive player legally causes a turnover by his positive, aggressive action(s)."),
                p(strong("PF"), "- Personal Fouls; A personal foul is a breach of the rules that concerns illegal personal contact with an opponent. It is the most common type of foul in basketball."),
                p(strong("TO"), "- Turnovers; A technical foul against a team that is in possession of the ball is a blatant example of a turnover, because the opponent is awarded a free throw in addition to possession of the ball."),
                p(strong("DBLDBL"), "- Double Doubles; A double-double is defined as a performance in which a player accumulates a double-digit number total in two of five statistical categories—points, rebounds, assists, steals, and blocked shots—in a game."),
                p(strong("TRIDBL"), "- Triple Doubles; In basketball, a double is the accumulation of a double-digit number total in one of five statistical categories—points, rebounds, assists, steals, and blocked shots—in a game."),
                p(strong("DQ"), "- Disqualifacations; In basketball, disqualification is a penalty for certain offenses during the game. If a player is disqualified during a game, the player must leave the court."),
                p(strong("EJECT"), "- Ejections"),
                p(strong("TECH"), "- Technical Fouls; In basketball, a technical foul is any infraction of the rules penalized as a foul which does not involve physical contact during the course of play between opposing players on the court, or is a foul by a non-player."),
                p(strong("FLAG"), "- Flagrant Fouls; It is an unsportsmanlike act and the offender is ejected following confirmation by instant replay review."),
                p(strong("AST/TO"), "- Assists Per Turnovers"),
                p(strong("STL/TO"), "- Steals Per Turnovers"),
                p(strong("RAT"), "- NBA Rating"),
                p(strong("SCEFF"), "- Scoring Efficiency"),
                p(strong("SHEFF"), "- Shooting Efficiency"),
                p(strong("PER"), "- Player Efficiency Rating"),
                p(strong("PPS"), "- Points Per Shot per game")
                 
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