graphFournees <- function(pains, fournees){
  g1 <- ggplot(pains, aes(Type, Poids, fill = Type)) + 
    geom_col() +
    theme(legend.position = "bottom") +
    coord_flip() +
    geom_hline(yintercept = max(colSums(fournees)), linetype = "dashed") +
    scale_fill_manual("Type", values = c("brown3", "beige", "yellow", "darkgrey"))
  g2 <- reshape2::melt(fournees) %>% 
    rename(Type = Var1, Fournee = Var2, Poids = value) %>% 
    ggplot(aes(Fournee, Poids, fill = Type)) + 
    geom_col() +
    theme(legend.position = "bottom") +
    scale_fill_manual("Type", values = c("darkgrey", "yellow", "brown3", "beige"))
  cowplot::plot_grid(g1, g2, nrow = 2)
}
