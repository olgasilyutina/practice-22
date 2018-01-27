#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



library(ggplot2)
library(shiny)
data(MovieLense)
print_plot <- function(user, film){
  ratings_movies <- MovieLense[rowCounts(MovieLense) > user, colCounts(MovieLense) > film] 
  average_ratings_per_user <- rowMeans(ratings_movies)
  
  # draw the histogram with the specified number of bins
  p <- ggplot()+geom_histogram(aes(x=average_ratings_per_user)) +
    ggtitle("Распределение средних оценок пользователей")
  print(p)
}

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Оценки пользователей"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("user",
                     "Number of users' marks:",
                     min = 0,
                     max = 735,
                     value = 10),
         sliderInput("film",
                     "Number of films' marks:",
                     min = 0,
                     max = 583,
                     value = 10)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     print_plot(input$user, input$film)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)


