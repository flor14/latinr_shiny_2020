########## Carga de librerias necesarias.

library("shiny")
library("shinythemes") # Para cambiarle el tema de colores.

########## Interfaz de usuarie.

ui <- fluidPage(
  title = "Emoji Data Explorer",       # Titulo para la barrita del navegador web.
  theme = shinytheme("cerulean"),      # Le ponemos un lindo tema de colores!
  titlePanel("Emoji Data Explorer"),   # Titulo del top de la pagina.
  navbarPage(                          # Vamos a tener un panel de tabs.
    title = "Filtrando",               # Titulo de la tabla de tabs.
    tabPanel(                          # Un tab para analisis por emoji.
      "Por emoji",                     # Titulo del tab.
      selectInput(                     # Input de selector de opciones.
        "selector_emoji",              # ID del selector de emojis.
        label = "Emoji",               # Label del selector.
        choices = NULL,                # Opciones posibles para seleccionar (NULL por ahora).
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
      plotOutput("por_emoji")          # Lugar donde ira el plot para mostrar el grafico por emoji.
    ),
    tabPanel(                          # Un tab para analisis por paises.
      "Por pais",                      # Titulo del tab.
      selectInput(                     # Input de selector de opciones.
        "selector_pais",               # ID del selector de paises.
        label = "Paises",              # Label del selector.
        choices = NULL,                # Opciones posibles para seleccionar (NULL por ahora).
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
      plotOutput("por_pais")           # Lugar donde ira el plot para mostrar el grafico por paises.
    )
  )
)

########## Codigo de servidor.

server <- function(input, output, session) {
  # No tenemos codigo servidor aun :'(
}

########## Ejecutamos la app!

shinyApp(ui, server)
