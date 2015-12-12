
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

## rf
fit <- train(Area~., data=training, method="rf")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)

## gbm (generalized boosted regression models)
library(gbm)
fit <- train(Area~., data=training, method="gbm")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)

## glm
fit <- train(Area~., data=training, method="glm", family="binomial")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)

## lda (linear discriminant analysis)
fit <- train(Area~., data=training, method="lda")
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)

## stacking (gam selected arbitrarily)
df <- data.frame(pred1, pred2, pred3, Area=testing$Area)
fit <- train(Area~., data=df, method="gam")
pred <- predict(fit, df)

## importance
varImp(fit)

## pca
preProcess(olive[-1], method="pca", thresh=0.9)
## also
fit <- train(Area~., data=training, method="rf", preProcess="pca", thresh=0.9)
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)

## rpart (CART)
fit <- train(Area~., data=training, method="rpart")
plot(fit$finalModel)
text(fit$finalModel)

## lasso
library(elasticnet)
fit <- enet(as.matrix(training[-1]), as.numeric(training[,1]), lambda=0) ## if lambda = 0, enet = lasso
plot.enet(fit, xvar="penalty", use.color=TRUE)

## svm
library(e1071)
fit <- svm(Area~., data=training)
pred <- predict(fit, testing)
confusionMatrix(pred, testing$Area)


