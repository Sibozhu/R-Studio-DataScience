#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- navbarPage(
  title = "Tweets that Mentioning President Trump",
  navbarMenu(
    title = "Geolocation Study",
    tabPanel("United States",
             div("From a two hour tweets capturing process, I collected over 200,000 tweets that mentioning President Trump domestically."),
             div("This is the Plot that indicates all the Tweets that is mentioning President Trump within the whole United Stated Region."),
             splitLayout(img(src="USplot.JPG", align = "center"))),
    tabPanel("New York State",
             div("This is the Plot that indicates all the Tweets that is mentioning President Trump within the New York State."),
             splitLayout(img(src="NewY.JPG", align = "center"))),
    tabPanel("New Jersey", 
             div("This is the Plot that indicates all the Tweets that is mentioning President Trump within the whole New Jersey Region."),
             splitLayout(img(src="NewJ.JPG", align = "center"))),
    tabPanel("California",
             div("This is the Plot that indicates all the Tweets that is mentioning President Trump within the California Region."),
             splitLayout(img(src="Cali.JPG", align = "center")))),
  navbarMenu(
    title = "US Cities",
    tabPanel("United States",
             div("This is the Plot that indicates the Top 15 cities that have the most Tweets mentioning President Trump within New York State"),
             splitLayout(img(src="NYcities.JPG", align = "center"))),
    tabPanel("New York State",
             div("This is the Plot that indicates the Top 15 cities that have the most Tweets mentioning President Trump within New Jersey State"),
             splitLayout(img(src="NJcities.JPG", align = "center"))),
    tabPanel("New Jersey", 
             div("This is the Plot that indicates the Top 15 cities that have the most Tweets mentioning President Trump within California region"),
             splitLayout(img(src="Cacities.JPG", align = "center"))),
    tabPanel("California",
             div("This is the Plot that indicates the Top 15 cities that have the most Tweets mentioning President Trump within the whole United States region"),
             splitLayout(img(src="UScities.JPG", align = "center")))),
  navbarMenu(
    title = "Stats",
    tabPanel("Matrix Plot",
             div("This is the matrix plot that I build in order to find relations between different parameters"),
             splitLayout(img(src="matrixplot.JPG", align = "center"))),
    tabPanel("Regression Plot", 
             div("This is the linear regression that I build in order to find relations between followers count and listed count"),
             splitLayout(img(src="regplot.JPG", align = "center"))),
    tabPanel("Residual and Q-Q Plot",
             div("This is the Residuals vs Fitted plot and Normal Q-Q plot"),
             splitLayout(img(src="resPlot.JPG", align = "center")))),
  navbarMenu(
    title = "Word Cloud",
    tabPanel("Tweets about President Trump",
             div("This is the word cloud generated from all the tweets that mentioning President Trump"),
             splitLayout(img(src="tagcloud.JPG", align = "center"))),
    tabPanel("President Trump's own Tweets' Analysis",
             div("This is the word cloud generated from President Trump his own Twitter"),
             splitLayout(img(src="trumpcloud.JPG", align = "center"))))
)
    

server <- function(session,input,output){
  
}

shinyApp(ui = ui, server = server)