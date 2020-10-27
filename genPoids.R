genPoids <- function(min = 0, max = 300, mean = 90, sd = 20){
  x <- round(rnorm(1, mean = mean, sd = sd))
  if(x < min)
    x <- min
  if(x > max)
    x <- max
  return(x)
}