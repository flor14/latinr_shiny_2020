########## Carga de librerias necesarias.

library("dplyr")
library("ggplot2")
library("shiny")
library("tibble") # Parece que `emo` usa tibble pero no lo instala.
library("tidyr")

########## Codigo temporal, para generar dataset de prueba.

if (!require("emo")) {
  remotes::install_github("hadley/emo")
  library("emo")
}

# Genero el dataset de ejemplo.
set.seed(8818)
paises <- ji_find("flag")$emoji[1:10] # Vamos a samplear de las primeras 10 banderas.
emo_opts <- jis$emoji[1:50] # Vamos samplear de los primeros 50 emojis.
# Sampleamos 500 filas de banderas y top_{1..5} emojis.
emo_datos <- tibble(
  pais = sample(paises, 500, replace = TRUE),
  top_1 = sample(emo_opts, 500, replace = TRUE),
  top_2 = sample(emo_opts, 500, replace = TRUE),
  top_3 = sample(emo_opts, 500, replace = TRUE),
  top_4 = sample(emo_opts, 500, replace = TRUE),
  top_5 = sample(emo_opts, 500, replace = TRUE)
)

########## Interfaz de usuario.

ui <- fluidPage(
  title = "Emoji Data Explorer",       # Titulo para la barrita del explorador.
  titlePanel("Emoji Data Explorer"),   # Titulo el top de la pagina.
  tabsetPanel(                         # Vamos a tener un panel de tabs (con dos tabs, por ahora..).
    tabPanel(                          # Un tab para analisis por pais.
      "Por pais",                      # Titulo del tab.
      selectInput(
        "selector_pais",               # ID del selector de paises.
        label = "Paises",              # Label del selector.
        choices = paises,              # Opciones posibles para seleccionar.
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
      plotOutput("por_pais")           # Plot para mostrar el grafico por pais.
    ),
    tabPanel( # Un tab para analisis por emoji.
      "Por emoji",                     # Titulo del tab.
      selectInput(
        "selector_emoji",              # ID del selector de paises.
        label = "Emoji",               # Label del selector.
        choices = emo_opts,            # Opciones posibles para seleccionar.
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
      plotOutput("por_emoji")          # Plot para mostrar el grafico por emoji.
    )
  )
)

########## Codigo de servidor.

server <- function(input, output, session) {
  output$por_pais <- renderPlot({
    filter(emo_datos, pais %in% input$selector_pais) %>%
      select(-pais) %>%
      pivot_longer(cols = starts_with("top_"), values_to = "Emoji") %>%
      ggplot(aes(x = Emoji)) + geom_bar()
  })
  output$por_emoji <- renderPlot({
    filter(
      emo_datos,
      top_1 %in% input$selector_emoji |
        top_2 %in% input$selector_emoji |
        top_3 %in% input$selector_emoji |
        top_4 %in% input$selector_emoji |
        top_5 %in% input$selector_emoji
    ) %>%
      select(pais) %>%
      ggplot(aes(x = pais)) + geom_bar()
  })
}

########## Ejecutamos la app!

shinyApp(ui, server)
