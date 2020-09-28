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
      choices = c("A", "B", "C"),    # Opciones posibles para seleccionar.
      multiple = TRUE                # Permite seleccionar mas de uno.
    )),
    tabPanel(                          # Un tab para analisis por paises.
      "Por pais",                      # Titulo del tab.
      checkboxGroupInput(                     # Input de selector de opciones.
        "selector_pais",               # ID del selector de paises.
        label = "Paises",              # Label del selector.
        choices = c("A", "B", "C")    # Opciones posibles para seleccionar.

      )))

########## Codigo de servidor.

server <- function(input, output, session) {
  # No tenemos codigo servidor aun :'(
}

########## Ejecutamos la app!

shinyApp(ui, server)
