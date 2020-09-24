library("shiny")
library("tidyverse")
library("ggplot2")
library("shinythemes")

ui<- fluidPage(theme = shinytheme("lumen"), 
               h1(strong("R-Ladies Buenos Aires")),
               h4(em("My first ShinyApp")),
               sidebarLayout(
               sidebarPanel(radioButtons(inputId = "axis_x",
                                          label = "X",
                                          selected = "displ",
                                          choices= c("Highway miles per gallon" = "hwy",
                                                     "City miles per gallon" = "cty",
                                                     "Engine displacement, in litres" = "displ")),
                             radioButtons("axis_y",
                                          "Y",
                                          selected = "hwy",
                                          choices= c("Highway miles per gallon" = "hwy",
                                                     "City miles per gallon" = "cty",
                                                     "Engine displacement, in litres" = "displ")),
                             radioButtons("class",
                                          "Class",
                                          choices= c("Type of car" = "class",
                                                     "Number of cylinders" = "cyl",
                                                     "Model name" = "model",
                                                     "Manufacturer" = "manufacturer")),
                img(src='nametag_7x5.png', 
                    width= 200, 
                    align = "topright")),
                mainPanel(plotOutput("plot")) #mainPanel
                ) #sidebarLayout
) #fluidPage


server <- function(input, output) {
  
  output$plot <- renderPlot({ print(ggplot(data = mpg) + 
                              geom_point(mapping = aes_string(x = input$axis_x,
                                                              y = input$axis_y,
                                                              color = input$class)))
  }
    )}
                                                  

shinyApp(ui = ui, server = server) 


