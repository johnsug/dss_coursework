
## example code ###############################################################################################
set.seed(100)
x=1:90
y=20*x + floor(runif(90,-80,80))
y=y + c(rep(0,80), (1:10)*runif(10, -70, -30))

plot(x, y)
z <- c(rep(0, 80), 81:90)

summary(lm(y~x))     # adj. R2 = 0.9517
summary(lm(y~x+z))   # adj. R2 = 0.9892

## alternatively, use the lsp (linear spline) function in the rms (regression model strategies) package #######

library(rms)
zz <- lsp(x, 80)

## produces the same results
summary(lm(y~x+z)) 
summary(lm(y~x+zz))

