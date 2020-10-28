#' @include utils-pipe.R
#' @import ggplot2
#' @importFrom dplyr rename
#' @importFrom reshape2 melt
NULL

#' Graphique des fournees
#'
#' @param pains df. Table des pains.
#' @param fournees df. Table des fournees.
#'
#' @return
#' @export
#'
#' @examples
graphFournees <- function(pains, fournees){
  # g1 <- ggplot(pains, aes(Type, Poids, fill = Type)) +
  #   geom_col() +
  #   theme(legend.position = "bottom") +
  #   coord_flip() +
  #   geom_hline(yintercept = max(colSums(fournees)), linetype = "dashed") +
  #   scale_fill_manual("Type", values = c("brown3", "beige", "yellow", "darkgrey"))
  melt(fournees) %>%
    rename(Type = Var1, Fournee = Var2, Poids = value) %>%
    ggplot(aes(Fournee, Poids, fill = Type)) +
    geom_col() +
    theme(legend.position = "bottom") +
    scale_fill_manual("Type", values = c("darkgrey", "yellow", "brown3", "beige"))
}
