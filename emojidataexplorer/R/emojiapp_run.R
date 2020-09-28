#' Start emojidataexplorer
#' @title Emoji Data Explorer
#' @description Shiny app para explorar emojis por país latinoamericano.
#' @keywords shiny, emoji
#' @examples
#' \dontrun{
#' library(emojidataexplorer)
#' emojiapp::emojiapp_run()
#' }
#' @export

emojiapp_run <- function(){
  appDir <- system.file("shiny", package = "emojidataexplorer")
  if (appDir == "") {
    stop("No puedo encontrar el directorio. Trata de re-instalar `emojidataexplorer`.", call. = FALSE)
  }

shiny::runApp(appDir, display.mode = "normal")
}
