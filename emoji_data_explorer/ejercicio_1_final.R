########## Carga de librerias necesarias.

library("shiny")
library("shinythemes") # Para cambiarle el tema de colores.

########## Interfaz de usuarie.

ui <- navbarPage(                      # Vamos a tener un panel de tabs.
    title = "Emoji Data Explorer",     # Titulo de la tabla de tabs.
    theme = shinytheme("cerulean"),    # Le ponemos un lindo tema de colores!
    tabPanel(                          # Un tab para analisis por emoji.
      "Por emoji",                     # Titulo del tab.
      selectInput(                     # Input de selector de opciones.
        "selector_emoji",              # ID del selector de emojis.
        label = "Emoji",               # Label del selector.
        choices = unique(unlist(emo_datos[, -1])), # Opciones posibles para seleccionar.
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
                                       
      #  plotOutput("por_emoji")       # Lugar donde ira el plot para mostrar el grafico por emoji.
      
    ),
    tabPanel(                          # Un tab para analisis por paises.
      "Por pais",                      # Titulo del tab.
      selectInput(                     # Input de selector de opciones.
        "selector_pais",               # ID del selector de paises.
        label = "Paises",              # Label del selector.
        choices = unique(unlist(emo_datos$pais)), # Opciones posibles para seleccionar.
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
                                      
       # plotOutput("por_pais")        # Lugar donde ira el plot para mostrar el grafico por paises.
     
    ),
  tabPanel("Licencia",  tags$a(href="https://github.com/flor14/latinr_shiny_2020/blob/master/LICENSE.md", "Archivo con licencia MIT"))
  )


########## Codigo de servidor.

server <- function(input, output, session) {
  # No tenemos codigo servidor aun :'(
}

########## Ejecutamos la app!

shinyApp(ui, server)
