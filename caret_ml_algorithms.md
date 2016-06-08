
## CARET machine learning algorithms

```{r}
## init
library(caret)
library(pgmm)

data(olive)
olive <- olive[,-1]
olive$Area <- as.factor(olive$Area)

## subset data
set.seed(1000)
inTrain <- createDataPartition(1:nrow(olive), p = .6)[[1]]
training <- olive[inTrain,]
testing <- olive[-inTrain,]

## importance
varImp(fit)
```

## principal components analysis (pca)
```{r}
preProcess(olive[-1], method="pca", thresh=0.9)
## also
fit <- train(Area~., data=training, method="rf", preProcess="pca", thresh=0.9)
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)
```

## rpart (CART)
```{r}
fit <- train(Area~., data=training, method="rpart")
plot(fit$finalModel)
text(fit$finalModel)
```

## random forest
```{r}
fit <- train(Area~., data=training, method="rf")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)
```

## gbm (generalized boosted regression models)
```{r}
library(gbm)
fit <- train(Area~., data=training, method="gbm")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)
```

## general linear model (glm)
```{r}
fit <- train(Area~., data=training, method="glm", family="binomial")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)
```

## linear discriminant analysis -- assumes multivariate Gaussian with same covariates
```{r}
fit <- train(Area~., data=training, method="lda")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)
```

## quadratic discriminant analysis -- assumes multivariate Gaussian with DIFFERENT covariates

## naive bayes -- assumes independence between features
```{r}
fit <- train(Area~., data=training, method="nb")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)
```

## bagging
```{r}
fit <- train(Area~., data=training, method="treebag")  ## bagEarth, treebag, bagFDA
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area) 
```

## boosting
```{r}
fit <- train(Area~., data=training, method="ada")  ## gbm, mboost, ada, gamBoost
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area) 
```

## stacking (gam selected arbitrarily)
```{r}
df <- data.frame(pred1, pred2, pred3, Area=testing$Area)
fit <- train(Area~., data=df, method="gam")
pred <- predict(fit, df)
```

## lasso
```{r}
library(elasticnet)
fit <- enet(as.matrix(training[-1]), as.numeric(training[,1]), lambda=0) ## if lambda = 0, enet = lasso
plot.enet(fit, xvar="penalty", use.color=TRUE)
## also
fit <- train(Area~., data=training, method="lasso") ## ridge, lasso, relaxo
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area) 
```

## svm
```{r}
library(e1071)
fit <- svm(Area~., data=training)
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)
```
