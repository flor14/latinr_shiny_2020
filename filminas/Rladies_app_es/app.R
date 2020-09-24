library("shiny")
library("tidyverse")
library("shinythemes")

ui <- fluidPage(theme = shinytheme("lumen"), 
               h1(strong("Rladies Buenos Aires")), h4(em("Taller de Ciencia de Datos")),
               sidebarLayout(
               sidebarPanel(radioButtons("Vx",
                                         "Eje X",
                                         selected = "displ",
                                         choices= c("Millas de autopista por galón"="hwy",
                                                     "Millas de ciudad por galón"="cty",
                                                     "Cilindrada del motor (L)"="displ")),
                             radioButtons("Vy",
                                          "Eje Y",
                                          selected = "hwy",
                                          choices= c("Millas de autopista por galón"="hwy",
                                                     "Millas de ciudad por galón"="cty",
                                                     "Cilindrada del motor (L)"="displ")),
                             radioButtons("class",
                                          "Clase",
                                          choices= c("Tipo de auto"="class",
                                                     "Número de cilindros"="cyl",
                                                     "Modelo"="model",
                                                     "Marca"="manufacturer")),
                img(src='nametag_7x5.png', width= 200, align = "topright")),
                mainPanel(plotOutput("plot")) #mainPanel
                ) #sidebarLayout
) #fluidPage


server <- function(input, output) {
  
  output$coolplot <- renderPlot({ print(ggplot(data = mpg) + 
                                          geom_point(mapping = aes_string(x = input$Vx,
                                                                          y = input$Vy,
                                                                          color = input$class)))
  }
    )}
                                                  

shinyApp(ui = ui, server = server)

