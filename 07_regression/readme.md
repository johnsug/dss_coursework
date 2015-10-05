#### a few notes

##### residuals
* Influence: tells how much an outlier influences (skews) model parameters
  * sometimes called influence, leverage, or hat value
* dfbeta: tells how much change the  inclusion or exclusion of a sample induces in coefficents
* Cook's distance: tells how much a given sample changes a model

##### logistic models
* exp(b1) -1: increase in odds per increase in b1 
* exp(confint(glm(...))): confidence interval for glm coefficients
