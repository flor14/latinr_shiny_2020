########## Carga de librerias necesarias.

library("shiny")
library("shinythemes") # Para cambiarle el tema de colores.

########## Interfaz de usuarie.

ui <- navbarPage(
  theme = shinytheme("cerulean"),      # Le ponemos un lindo tema de colores!
  navbarPage(                          # Vamos a tener un panel de tabs.
    title = "Emoji Data Explorer",     # Titulo de la tabla de tabs.
    tabPanel(                          # Un tab para analisis por emoji.
      "Por emoji",                     # Titulo del tab.
      selectInput(                     # Input de selector de opciones.
        "selector_emoji",              # ID del selector de emojis.
        label = "Emoji",               # Label del selector.
        choices = NULL,                # Opciones posibles para seleccionar (NULL por ahora).
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
      plotOutput("por_emoji")          # Lugar donde ira el plot para mostrar el grafico por emoji.
    )
  )
)

########## Codigo de servidor.

server <- function(input, output, session) {
  # No tenemos codigo servidor aun :'(
}

########## Ejecutamos la app!

shinyApp(ui, server)
