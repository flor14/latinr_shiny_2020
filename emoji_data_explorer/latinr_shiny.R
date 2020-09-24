########## Carga de librerias necesarias.

library("dplyr")
library("forcats")
library("ggplot2")
library("shiny")
library("tidyr")
library("shinycssloaders")
library("shinythemes")

########## Codigo temporal, para generar dataset de prueba.

{
if (!require("emo")) {
  remotes::install_github("hadley/emo")
  library("emo")
}
library("tibble") # Parece que `emo` usa tibble pero no lo instala.

# Genero el dataset de ejemplo.
set.seed(8818)
paises <- ji_find("flag")$emoji[1:10] # Vamos a samplear de las primeras 10 banderas.
emo_opts <- jis$emoji[1:50] # Vamos samplear de los primeros 50 emojis.
# # Sampleamos 500 filas de banderas y top_{1..5} emojis.
# emo_datos <- tibble(
#   pais = sample(paises, 500, replace = TRUE),
#   top_1 = sample(emo_opts, 500, replace = TRUE),
#   top_2 = sample(emo_opts, 500, replace = TRUE),
#   top_3 = sample(emo_opts, 500, replace = TRUE),
#   top_4 = sample(emo_opts, 500, replace = TRUE),
#   top_5 = sample(emo_opts, 500, replace = TRUE)
# )
#
# # Obtener la imagen a partir del emoji.
# library("purrr")
# library("rvest")
#
# # Codigo de https://www.hvitfeldt.me/blog/real-emojis-in-ggplot2/
# emoji_to_link <- function(x, download_path = NULL) {
#   url_imagen <- paste0("https://emojipedia.org/emoji/", x) %>%
#     read_html() %>%
#     html_nodes("tr td a") %>%
#     .[1] %>%
#     html_attr("href") %>%
#     paste0("https://emojipedia.org/", .) %>%
#     read_html() %>%
#     html_node('div[class="vendor-image"] img') %>%
#     html_attr("src")
#   if (!is.null(download_path)) {
#     # Si me dieron path destino, entonces descargo la imagen.
#     dest_file <- paste0(download_path, "/", basename(url_imagen))
#     download.file(url_imagen, destfile = dest_file)
#     url_imagen <- dest_file
#   }
#   url_imagen
# }
#
# # Codigo de https://www.hvitfeldt.me/blog/real-emojis-in-ggplot2/
# link_to_img <- function(x, size = 25) {
#   paste0("<img src='", x, "' width='", size, "'/>")
# }
#
# emoji_img_map <- data.frame(
#   emoji = unique(unlist(emo_datos)),
#   label = unlist(map(unique(unlist(emo_datos)), ~link_to_img(emoji_to_link(.x, "Imagenes/"))))
# )
#
# readr::write_rds(emo_datos, "Datos/emo_datos.rds")
# readr::write_rds(emoji_img_map, "Datos/emoji_img_map.rds")
emo_datos <- readr::read_rds("Datos/emo_datos.rds")
emoji_img_map <- readr::read_rds("Datos/emoji_img_map.rds")
}

########## Interfaz de usuario.

ui <- fluidPage(theme = shinytheme("cerulean"),
  title = "Emoji Data Explorer",       # Titulo para la barrita del explorador.
  titlePanel("Emoji Data Explorer"),   # Titulo el top de la pagina.
  navbarPage(title = "Datos",          # Vamos a tener un panel de tabs (con dos tabs, por ahora..).
    tabPanel(                          # Un tab para analisis por pais.
      "Por pais",                      # Titulo del tab.
      selectInput(
        "selector_pais",               # ID del selector de paises.
        label = "Paises",              # Label del selector.
        choices = paises,              # Opciones posibles para seleccionar.
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
      shinycssloaders::withSpinner(
      plotOutput("por_pais"))           # Plot para mostrar el grafico por pais.
    ),
    tabPanel( # Un tab para analisis por emoji.
      "Por emoji",                     # Titulo del tab.
      selectInput(
        "selector_emoji",              # ID del selector de paises.
        label = "Emoji",               # Label del selector.
        choices = emo_opts,            # Opciones posibles para seleccionar.
        multiple = TRUE                # Permite seleccionar mas de uno.
      ),
      shinycssloaders::withSpinner(
      plotOutput("por_emoji"))          # Plot para mostrar el grafico por emoji.
    )
  )
)

########## Codigo de servidor.

# Funcion para generar el plot.
# `data_conteos` debe ser un data.frame con columnas `x` y `n`.
plot_barras <- function(data_conteos) {
  # Reordenamos de mayor a menor los datos del eje x.
  ggplot(data_conteos, aes(x = fct_reorder(x, n, .desc = TRUE), y = n)) +
    geom_col() +                       # Grafico de barras.
    labs(x = NULL)                     # Borramos el label del eje x.
}

# Funcion para generar el plot con imagenes.
# `data_conteos` debe ser un data.frame con columnas `x` y `n`.
# `emoji_img_map` debe ser un data.frame con columnas `emoji` y `label`.
plot_barras_imgs <- function(data_conteos, emoji_img_map) {
  library("ggtext")
  # Reordenamos de mayor a menor los datos del eje x.
  merge(data_conteos, emoji_img_map, by.x = "x", by.y = "emoji") %>%
  ggplot(aes(x = fct_reorder(label, n, .desc = TRUE), y = n)) +
    geom_col() +                       # Grafico de barras.
    theme(axis.text.x = element_markdown()) + # Para poner la imagen del emoji en vez del emoji.
    labs(x = NULL)                     # Borramos el label del eje x.
}

server <- function(input, output, session) {
  output$por_pais <- renderPlot({
    filter(emo_datos, pais %in% req(input$selector_pais)) %>%
      select(-pais) %>%
      pivot_longer(cols = starts_with("top_")) %>%
      count(value, sort = TRUE) %>%
      mutate(x = value) %>%
      # plot_barras()
      plot_barras_imgs(emoji_img_map)
  })
  output$por_emoji <- renderPlot({
    filter(
      emo_datos,
      top_1 %in% req(input$selector_emoji) |
        top_2 %in% input$selector_emoji |
        top_3 %in% input$selector_emoji |
        top_4 %in% input$selector_emoji |
        top_5 %in% input$selector_emoji
    ) %>%
      select(pais) %>%
      count(pais, sort = TRUE) %>%
      mutate(x = pais) %>%
      # plot_barras()
      plot_barras_imgs(emoji_img_map)
  })
}

########## Ejecutamos la app!

shinyApp(ui, server)
