
![](latin-shiny.png)

# Taller de Shiny en LatinR 2020

## Profes

* [Florencia D'Andrea]()
* [Juan Cruz Rodríguez](https://jcrodriguez.rbind.io/)
* [Vilma Romero]()


## Emoji Shiny app

### Información para usuaries

Puedes bajarte la app a tu computadora usando el siguiente código

``` 
library(devtools)
devtools::install_github("flor14/latinr_shiny_2020", subdir = "emoji_data_explorer")
library(emoji_data_explorer)
emoji_data_explorer::emoji_app()
```

## Links de interés

* [Cheatsheet de Shiny](https://github.com/rstudio/cheatsheets/raw/master/translations/spanish/shiny_Spanish.pdf) [español]: Hoja resumen de las funciones y estructuras más utilizadas para crear Shiny apps.

* [Referencia de funciones de Shiny](https://shiny.rstudio.com/reference/shiny/1.5.0/) [inglés]: Listado con todas las funciones de Shiny, organizadas y con una pequeña descripción.

* [Galería de apps de Shiny](https://shiny.rstudio.com/gallery/) [inglés]: Página con muchas Shiny app de ejemplo. Permite jugar con las app de ejemplo, y presenta todo el código necesario para replicar estas app en tu computadora. La [sección de Widgets](https://shiny.rstudio.com/gallery/#widgets) resulta muy útil para quien comienza con el mundo de Shiny.

* [Mastering Shiny](https://mastering-shiny.org/) [inglés]: Libro completísimo que te lleva desde 0 a Shiny master.

* [Engineering Production-Grade Shiny Apps](https://engineering-shiny.org/) [inglés]: Libro que te enseña buenas prácticas para generar una Shiny app modularizable y escalable, lista para tener en producción.

## Lineamientos para contribuir con la app

Reporte de errores:

- Preguntas, comentarios, informes de errores: abra un `issue` en el repositorio de este proyecto [aquí](https://github.com/flor14/latinr_shiny_2020/issues).

Contribuye a nuestro software:

- Abra un `issue` en este repositorio que describa los cambios que le gustaría realizar en el software y realice un `pull request` con los cambios. La descripción del `pull request` debe hacer referencia al problema correspondiente.
