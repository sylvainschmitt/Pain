rm(list = ls()) ; gc()
sapply(c("genPains.R", "genPoids.R", "calculTotaux.R", "calculFournees.R", "graphFournees.R"), source)
library(tidyverse)
theme_set(bayesplot::theme_default())

pains <- data.frame(Type = c(rep("Nature",4), rep("Graines",3), rep("PAC",1), rep("Sarasin",2)),
                    Poids = as.character(c(0.5, 1, 1.5, 2, 0.5, 1, 1.5, 0.25, 0.5, 1)),
                    "Le chêne" = as.integer(sample(0:10, 10)),
                    "RAB" = as.integer(sample(0:10, 10)))


# test <- genPains()
totaux <- calculTotaux(pains)
fournees <- calculFournees(totaux)
graphFournees(totaux, fournees)



