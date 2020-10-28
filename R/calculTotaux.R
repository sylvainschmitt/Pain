#' @include utils-pipe.R
#' @importFrom dplyr mutate group_by summarise
#' @importFrom reshape2 melt
NULL

#' Calcul totaux
#'
#' @param pains df. Table des pains.
#'
#' @return
#' @export
#'
#' @examples
#'
calculTotaux <- function(pains){
  pains %>%
    mutate(Poids = as.numeric(as.character(Poids))) %>%
    melt(id.vars = c("Type", "Poids"),
                   variable.name = "Debouche", value.name = "Nombre") %>%
    group_by(Type) %>%
    summarise(Poids = sum(Poids*Nombre))
}
