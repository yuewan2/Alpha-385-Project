library(shiny)
library(ggplot2)

Home_Guest_Visual = read.csv("Home_Guest_Visual.csv")
# Home_Guest_Scatter = read.csv("Home_Guest_Scatter.csv")
Color = Home_Guest_Visual$TEAM[1:30]
team_stats = read.csv("Team_Stats_2016_2017.csv")[,-1]
regression_predictor = colnames(team_stats)[4:10]

# Define UI ----
ui = shinyUI(
  
  fluidPage(
    # navigation bar:
    navbarPage(h4("NBA Data Analysis"),
               
               # ------------- first page Home/Away Effects: -------------
               
               tabPanel(
                  h5("Home/Away Effects"), 
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
                                   choices=c("Scatterplot","Barplot")),
                      submitButton("Generate the plot")
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
                  
               ),
               
               # ------------- second page choosing from slr/mlr: -------------
               
               navbarMenu(h5("Prediction"), 
                          
                 # ------------- Simple Linear Regression Page -------------
                          
                 tabPanel(
                    "Simple Linear Regression", 
                    titlePanel(h2("NBA Data Analysis")),
                    sidebarLayout(
                      sidebarPanel(
                        h3("Predict with SLR"),
                        "In this section, we are going to generate a",
                        strong("Simple"),
                        "Linear Regression model with Win Ratio as response.",
                        p("In the below, you are going to choose your own predictor from are ASR, REB, BLK, STL, TOV and PER."),
                        p("Our recommended SLR predictor is PER, since it is a clever way of combining most of the NBA performance stats (See detail in dictionary)"),
                        
                        selectInput("indep", label = "Variable", choices = c(None = '.', regression_predictor)),
                        radioButtons(
                          "line",
                          "Do you want to include the regression line into the regression graph?",
                          choices = c("Yes", "No")
                        ),
                        submitButton("Generate")
                                
                      ),
                      mainPanel(
                        tabsetPanel(
                          tabPanel("Summary", 
                                   h3("Summary of the Simple Linear Regression"),
                                   verbatimTextOutput("summary_SL")),
                          tabPanel("Graph", 
                                   h3("Graph of the Simple Linear Regression"),
                                   plotOutput("graph_SL"))
                        )
                      )
                    )
                 ),
                 
                 # ------------- Multiple Linear Regression Page -------------
                 
                 tabPanel(
                   "Multiple Linear Regression",
                   titlePanel(h2("NBA Data Analysis")),
                   sidebarLayout(
                     sidebarPanel(
                       h3("Predict with MLR"),
                       "In this section, we are going to generate a",
                       strong("multiple"), 
                       "linear regression model towards the result of Win Ratio.",
                       p("For Win Ratio as a response, the predictors you can choose from AST, PTS, REB, BLK, STL, TOV and PER."),
                       p("In order for the MLR to be generated, you must choose exactly 7 variables."),
                       p("Our recommended SLR predictor is PER, since it is a clever way of combining most "),
                       selectInput("indep1", label = "Variable 1", choices = c(None = '.', regression_predictor)),
                       selectInput("indep2", label = "Variable 2", choices = c(None = '.', regression_predictor)),
                       selectInput("indep3", label = "Variable 3", choices = c(None = '.', regression_predictor)),
                       selectInput("indep4", label = "Variable 4", choices = c(None = '.', regression_predictor)),
                       selectInput("indep5", label = "Variable 5", choices = c(None = '.', regression_predictor)),
                       selectInput("indep6", label = "Variable 6", choices = c(None = '.', regression_predictor)),
                       selectInput("indep7", label = "Variable 7", choices = c(None = '.', regression_predictor)),
                       submitButton("Generate")
                     ),
                     mainPanel(
                       tabsetPanel(
                         tabPanel("Summary", 
                                  h3("Summary of the Multiple Linear Regression"),
                                  verbatimTextOutput("summary_ML")),
                         tabPanel("Graph", 
                                  h3("Graph of the Multiple Linear Regression"),
                                  verbatimTextOutput("graph_ML"))
                       )
                     )
                   )
                 
                 )
              )

    
    )
  
  
))

# Define server logic ----
server = shinyServer(function(input, output) {

  # ------------- Reactive Variable for Home/Away Effects Graph -------------
  
  active_var = reactive({
    req(input$var_chosen != ".")
    if(input$var_chosen == "W"){
      Home_Guest_Visual$W
    }else if(input$var_chosen == "L"){
      Home_Guest_Visual$L
    }else if(input$var_chosen == "WIN_Ratio"){
      Home_Guest_Visual$WIN_Ratio
    }else if(input$var_chosen == "MIN"){
      Home_Guest_Visual$MIN
    }else if(input$var_chosen == "PTS"){
      Home_Guest_Visual$PTS
    }else if(input$var_chosen == "FGM"){
      Home_Guest_Visual$FGM
    }else if(input$var_chosen == "FGA"){
      Home_Guest_Visual$FGA
    }else if(input$var_chosen == "FG_Ratio"){
      Home_Guest_Visual$FG_Ratio
    }else if(input$var_chosen == "X3PM"){
      Home_Guest_Visual$X3PM
    }else if(input$var_chosen == "X3PA"){
      Home_Guest_Visual$X3PA
    }else if(input$var_chosen == "X3P_Ratio"){
      Home_Guest_Visual$X3P_Ratio
    }else if(input$var_chosen == "FTM"){
      Home_Guest_Visual$FTM
    }else if(input$var_chosen == "FTA"){
      Home_Guest_Visual$FTA
    }else if(input$var_chosen == "OREB"){
      Home_Guest_Visual$OREB
    }else if(input$var_chosen == "DREB"){
      Home_Guest_Visual$DREB
    }else if(input$var_chosen == "REB"){
      Home_Guest_Visual$REB
    }else if(input$var_chosen == "AST"){
      Home_Guest_Visual$AST
    }else if(input$var_chosen == "TOV"){
      Home_Guest_Visual$TOV
    }else if(input$var_chosen == "STL"){
      Home_Guest_Visual$STL
    }else if(input$var_chosen == "BLK"){
      Home_Guest_Visual$BLK
    }else if(input$var_chosen == "BLKA"){
      Home_Guest_Visual$BLKA
    }else if(input$var_chosen == "PF"){
      Home_Guest_Visual$PF
    }else if(input$var_chosen == "PFD"){
      Home_Guest_Visual$PFD
    }
  })
  
  fit_SL = reactive({
    req(input$indep != '.')
    lm(as.formula(paste("Win_Ratio", "~", input$indep)), data = team_stats)
  })
  
  fit_ML = reactive({
    req(input$indep1 != '.', input$indep2 != '.', input$indep3 != '.', input$indep4 != '.', input$indep5 != '.', input$indep6 != '.', input$indep7 != '.')
    lm(as.formula(paste("Win_Ratio", "~", input$indep1, "+", input$indep2, "+", input$indep3, "+", input$indep4, "+", input$indep5, "+", input$indep6, "+", input$indep7)), data = team_stats)
  })
  
  # ------------- Plot output for Home/Away Effect -----------------
  
  output$plot = renderPlot({
    if(input$choice == "Barplot"){
      ggplot(Home_Guest_Visual) + geom_bar(aes(TEAM, active_var(), fill = HOME_GUEST), position="dodge",stat="identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + ylab("Variable_Chosen")
    }else{
      ggplot() + geom_point(aes(y = active_var()[1:30], x = active_var()[31:60], color = Home_Guest_Visual$TEAM[1:30])) + geom_abline(intercept = 0, slope = 1, linetype = "dashed") + xlab("Guest Performance") + ylab("Home Performance") #+ expand_limits(x = 0, y = 0)
    }
  })
  
  # ------------- Summary for Simple Linear Regression -------------
  
  output$summary_SL = renderPrint({
    req(input$indep != '.')
    summary(fit_SL())
  })
  
  output$graph_SL = renderPlot({
    req(input$indep != '.')
    if(input$line == "Yes") {
      ggplot(team_stats, aes_string(x = input$indep, y = "Win_Ratio")) + geom_point(size = 0.5) + geom_smooth(method = "lm") + geom_text(label = team_stats$Team_Abbr, hjust = 0, vjust = 0)
    } else{
      ggplot(team_stats, aes_string(x = input$indep, y = "Win_Ratio")) + geom_point(size = 0.5) + geom_text(label = team_stats$Team_Abbr, hjust = 0, vjust = 0)
    }
  })
  
  # ------------- Summary for Multiple Linear Regression -------------
  
  output$summary_ML = renderPrint({
    req(input$indep1 != '.', input$indep2 != '.', input$indep3 != '.', input$indep4 != '.', input$indep5 != '.', input$indep6 != '.')
    summary(fit_ML())
  })
  
  # output$graph_SL = renderPlot({
  #   req(input$indep != '.')
  #   if(input$line == "Yes") {
  #     ggplot(team_stats, aes_string(x = input$indep, y = "Win_Ratio")) + geom_point() + geom_smooth(method = "lm")
  #   } else{
  #     ggplot(team_stats, aes_string(x = input$indep, y = "Win_Ratio")) + geom_point()
  #   }
  # })
  
  
})

# Run the app ----
shinyApp(ui = ui, server = server)