#' @include utils-pipe.R
#' @import ggplot2
#' @importFrom dplyr rename
#' @importFrom reshape2 melt
NULL

#' Graphique des fournees
#'
#' @param fournees df. Table des fournees.
#'
#' @return
#' @export
#'
#' @examples
graphFournees <- function(fournees){
  melt(fournees, variable.name = "Fournee", value.name = "Poids") %>%
    ggplot(aes(Fournee, Poids, fill = Type)) +
    geom_col() +
    theme(legend.position = "bottom") +
    scale_fill_manual("Type", values = c("darkgrey", "yellow", "brown3", "beige"))
}
