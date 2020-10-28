#' Calcul Pain Global User Interface
#'
#' @return An html user interface.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  calculPainGUI()
#' }
#'
calculPainGUI <- function() {
  appDir <- system.file("calculPain", package = "Pain")
  if (appDir == "") {
    stop("Could not find gui Try re-installing `Pain`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
