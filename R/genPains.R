#' Generate Pains
#'
#' Generate fake totaux for pains.
#'
#' @param Vm int. Volume maximum d'une fournee.
#'
#' @return
#' @export
#'
#' @examples
genPains <- function(Vm = 60){
  S <- genPoids(max = 15, mean = 7, sd = 3) # N nature
  P <- genPoids(max = 15, mean = 7, sd = 3) # N graine
  G <- genPoids(mean = 55, sd = 10) # N PAC
  N <- genPoids() # N sarasin
  Vm <- 60 # Volume max (kg)
  data.frame(Type = c("Sarasin", "PAC", "Graines", "Nature"),
             Poids = c(S, P, G, N))
}
