#' @include utils-pipe.R
#' @importFrom dplyr filter arrange
#' @importFrom tibble rownames_to_column
NULL

#' Calcul fournees
#'
#' @param pains df. Table des pains.
#' @param Vm int. Volume maximum d'une fournee.
#'
#' @return
#' @export
#'
#' @examples
calculFournees <- function(pains, Vm = 60){

  # Init
  N <- filter(pains, Type == "Nature")$Poids
  G <- filter(pains, Type == "Graines")$Poids
  P <- filter(pains, Type == "PAC")$Poids
  S <- filter(pains, Type == "Sarasin")$Poids

  ## 1 Calucl Nt
  Nt <- ceiling((N + G + P + S)/Vm) # Nombre de tournées
  fournees <- matrix(0, nrow = 4, ncol = Nt)
  rownames(fournees) <- c("Sarasin", "PAC", "Graines", "Nature")
  f <- 1

  ## 2 Fournees pleines
  Ntnature <- floor(N/Vm)
  Nreste <- N - Vm*Ntnature
  Ntgraine <- floor(G/Vm)
  Greste <- G - Vm*Ntgraine
  if(Ntnature > 0) {
    for(t in 1:Ntnature) {
      fournees["Nature", f] <- Vm
      f <- f + 1
    }
  }
  if(Ntgraine > 0) {
    for(t in 1:Ntgraine) {
      fournees["Graines", f] <- Vm
      f <- f + 1
    }
  }

  ## 3 Remplissage
  dernier <- "Nature"
  restes <- data.frame(Type = c("Sarasin", "PAC", "Graines", "Nature"),
                       Poids = c(S, P, Greste, Nreste)) %>%
    arrange(desc(Poids))
  fin <- filter(restes, Type == dernier)
  restes <- filter(restes, Type != dernier)
  for(t in 1:nrow(restes)){
    f <- colSums(fournees) + restes[t,"Poids"]
    names(f) <- 1:ncol(fournees)
    f <- as.numeric(names(which.max(f[f < 60])[1]))
    fournees[as.character(restes$Type[t]),f] <- restes$Poids[t]
  }

  f <- colSums(fournees) + fin$Poids
  names(f) <- 1:ncol(fournees)
  if(f[which.min(f)] < 60) {
    fournees[as.character(fin$Type),which.min(f)] <- fin$Poids
  } else {
    f <- colSums(fournees)
    names(f) <- 1:ncol(fournees)
    Vf <- (sum(f[f < 60]) + fin$Poids) / length(f[f < 60])
    Vfin <- Vf - f[f < 60]
    fournees[as.character(fin$Type), as.numeric(names(Vfin))] <- Vfin
  }

  fournees <- as.data.frame(fournees)
  names(fournees) <-  paste("Fournee", 1:ncol(fournees))
  fournees <- rownames_to_column(fournees, "Type")

  return(fournees)
}
