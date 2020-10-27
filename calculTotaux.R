calculTotaux <- function(pains)
  pains %>% 
  mutate(Poids = as.numeric(as.character(Poids))) %>% 
  reshape2::melt(id.vars = c("Type", "Poids"), 
                 variable.name = "Debouche", value.name = "Nombre") %>% 
  group_by(Type) %>% 
  summarise(Poids = sum(Poids*Nombre))