#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(leaflet)
library(memoise)

ui <- navbarPage(
  title = "Tweets that Mentioning President Trump",
  navbarMenu(
    title = "Map",
    tabPanel("United States",
             div("I started to mine 2000 tweets mentiong starbucks all over the United States"),
             div("Each red point represents each tweet"),
             div("I found that there are some clustering among California and East Coast, so later when I plotted the sentiment scores, I first included those two area in comparison."),
             splitLayout(img(src="USplot.JPG", align = "center"))),
    tabPanel("New York State",
             div("This map shows all Tweets mentiong Starbucks three major marketing hashtags with sentiment scores around California."),
             div("The red points represent a positive attitude and blue points represent a negative attitude.The larger the point, the higher the absolute score."),
             splitLayout(img(src="NewY.JPG", align = "center"))),
    tabPanel("New Jersey", 
             div("This map shows all Tweets mentiong Starbucks three major marketing hashtags with sentiment scores around Massachussettes."),
             div("The red points represent a positive attitude and blue points represent a negative attitude.The larger the point, the higher the absolute score."),
             splitLayout(img(src="NewJ.JPG", align = "center"))),
    tabPanel("California",
             div("This map shows all Tweets mentiong Starbucks three major marketing hashtags with sentiment scores around New York."),
             div("The red points represent a positive attitude and blue points represent a negative attitude.The larger the point, the higher the absolute score."),
             splitLayout(img(src="Cali.JPG", align = "center")))),
  navbarMenu(
    title = "States",
    tabPanel("Matrix Plot",
             div("This graph shows that tweets' sentiment scores and its number with 0 being neutral, negative number representing negative attitude and positive number representing positive attitude."),
             div("We can see that the average sentiment scores for tweets mentioning starbucks is below 0, which means from those 2000 sample tweets , users on average hold negative attitude toward Starbucks. "),
             splitLayout(img(src="matrixplot.JPG", align = "center"))),
    tabPanel("Regression Plot", 
             div("Starbucks For Life Event is a promotion holding by Starbucks and can also be considered as a marketing strategy for Starbucks. Specifically, Starbucks aim to provide loyatly customers rewards and further market their new holiday products. This graph shows the tweets' sentiment scores when users mention this event."),
             div("Clearly, the average score is above 0. From those 1000 tweets, users on average hold a positive attitude toward Starbucks For Life Event."),
             splitLayout(img(src="regplot.JPG", align = "center"))),
    tabPanel("Residual and Q-Q Plot",
             div("Starbucks At Home is a hashtag promoting by Starbucks official to market their products, for example, their convenient K-Cup pods, VIA Instant. Coffee at home promotes customers to buy their products so that they can make their own coffee at home and aims to provide customers a perception of convenience and warm."),
             div("From the distribution graph, there are no negative sentiment scores toward this hashtag among 1000 tweets. "),
             splitLayout(img(src="resPlot.JPG", align = "center"))),
    tabPanel("Clustering",
             div("Starbucks Give Good is another hashtag and promotes the idea of giving. Give Good project aims to celebrate communities and local heroes with $1 million worth of Starbucks Cards throughout the month of December.It gives customers a perception of good and giving."),
             div("Surprisingly,the distribution graph shows that the mode is below 0. The average score is less than Starbucks At Home. Laterly, I will plot those sentiment scores on a US map to see which region specifically has a negative attitude toward this event."),
             splitLayout(img(src="clustering.JPG", align = "center")))),
  navbarMenu(
    title = "Word Cloud",
    tabPanel("Tweets about President Trump",
             div("This is the most frequent words distribution for 2000 tweets mentioned Starbucks"),
             div("The most frequent words include starbucks, rt(meaning retweeted),holiday, give good, gifts, free, chicago,etc."),
             splitLayout(img(src="tagcloud.JPG", align = "center"))),
    tabPanel("President Trump's own Tweets' Analysis",
             div("This is the most frequent words distribution for 1000 tweets mentioned Starbucks Give Good"),
             div("The most frequent words include giving, love, retweet, season, free, holiday, kindness, please, etc."),
             splitLayout(img(src="trumpcloud.JPG", align = "center"))))
)
    

server <- function(session,input,output){
  
}

shinyApp(ui = ui, server = server)