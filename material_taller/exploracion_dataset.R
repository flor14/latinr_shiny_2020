library("dplyr")   # Para transformar la data, y piping `%>%`
library("forcats") # Para reordenar las barras del plot.
library("ggplot2") # Para generar los plots.
library("readr")   # Para cargar el dataset.
library("tidyr")   # Para pivotear la tabla.

# Cargo el dataset.
emo_datos <- read_rds("Datos/emo_datos.rds")

## Veamos un grafico de baras con la cantidad de veces que se eligio cada emoji.
# Transformamos los datos para el plot.
datos_plot <- emo_datos %>%
  select(-pais) %>% # Seleccionamos todo menos la columna de pais (vamos a ver solo los emoji).
  pivot_longer(cols = starts_with("top_")) %>% # No tenemos en cuenta el orden de eleccion.
  count(value, sort = TRUE) %>% # Contamos cuantas veces se repite cada emoji.
  mutate(x = value) # Renombramos la variable `value` como `x` (va a ser nuestro eje x del plot).

# Generamos el grafico de barras.
ggplot(
  datos_plot,
  aes(
    x = fct_reorder(x, n, .desc = TRUE), # Reordenamos las barras de mayor a menor (repeticiones).
    y = n
  )
) +
  geom_col() + # Grafico de barras.
  labs(x = NULL) # Borramos el label del eje x.

# Funcion para generar el plot.
# `data_conteos` debe ser un data.frame con columnas `x` y `n`.
plot_barras <- function(data_conteos) {
  # Reordenamos de mayor a menor los datos del eje x.
  ggplot(data_conteos, aes(x = fct_reorder(x, n, .desc = TRUE), y = n)) +
    geom_col() +                       # Grafico de barras.
    labs(x = NULL)                     # Borramos el label del eje x.
}

plot_barras(datos_plot)


# Funcion para generar el plot con imagenes.
# `data_conteos` debe ser un data.frame con columnas `x` y `n`.
# `emoji_img_map` debe ser un data.frame con columnas `emoji` y `label`.
emoji_img_map <- read_rds("Datos/emoji_img_map.rds")
plot_barras <- function(data_conteos) {
  library("ggtext")
  # Reordenamos de mayor a menor los datos del eje x.
  merge(data_conteos, emoji_img_map, by.x = "x", by.y = "emoji") %>%
    ggplot(aes(x = fct_reorder(label, n, .desc = TRUE), y = n)) +
    geom_col() +                              # Grafico de barras.
    theme(axis.text.x = element_markdown()) + # Para poner la imagen del emoji en vez del emoji.
    labs(x = NULL)                            # Borramos el label del eje x.
}

plot_barras(datos_plot)
