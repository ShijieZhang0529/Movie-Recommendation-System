# install.packages("dplyr")
# install.packages("tidyr")
# install.packages("ggplot2")

library(dplyr)
library(tidyr)
library(ggplot2)

# 1.load data, split train dataset and test dataset
data <- read.csv("../data/ml-latest-small/ratings.csv")
set.seed(0)
test_idx <- sample(1:nrow(data), round(nrow(data)/5, 0))
train_idx <- setdiff(1:nrow(data), test_idx)

# train dataset
data_train <- data[train_idx,]
# test dataset
data_test <- data[test_idx,]

# user numbers (610)
U <- length(unique(data$userId))
# movies numbers (9724)
I <- length(unique(data$movieId))

# 2.Matrix Factorization
source("../lib/Probabilistic_Matrix_Factorization.R")
source("../lib/cross_validation.R")

# latent facotr dimesion
f_list <- seq(10, 20, 10)
# sigma
sigma <- seq(0.01, 0.02, 0.01)
sigma_q <- seq(0.1, 0.2, 0.1)
sigma_p <- seq(0.1, 0.2, 0.1)

f_l <- expand.grid(f_list, sigma, sigma_q, sigma_p)

result_summary <- array(NA, dim = c(nrow(f_l), 10, 4)) 
run_time <- system.time(for(i in 1:nrow(f_l)){
  par <- paste("f = ", f_l[i,1], ", sigma = ", f_l[i,2], ", sigma_q = ", f_l[i,3], "sigma_p = ", f_l[i, 4])
  cat(par, "\n")
  current_result <- cv.function(data, K = 5, f = f_l[i,1], U=U, V=I, sigma=f_l[i, 2], sigma_q=f_l[i, 3], sigma_p=f_l[i, 4])
  result_summary[,,i] <- matrix(unlist(current_result), ncol = 10, byrow = T) 
  print(result_summary)
  
})
save(result_summary, file = "../output/rmse.Rdata")


load("../output/rmse.Rdata")
rmse <- data.frame(rbind(t(result_summary[1,,]), t(result_summary[2,,])), train_test = rep(c("Train", "Test"), each = 4), par = rep(paste("f = ", f_l[,1], ", lambda = ", 10^f_l[,2]), times = 2)) %>% gather("epoch", "RMSE", -train_test, -par)
rmse$epoch <- as.numeric(gsub("X", "", rmse$epoch))
rmse %>% ggplot(aes(x = epoch, y = RMSE, col = train_test)) + geom_point() + facet_grid(~par)


result <- probgradesc(f = 10, U=, V=, sigma=, sigma_q=, sigma_p=, lambda = 0.1,lrate = 0.01, max.iter = 100, stopping.deriv = 0.01,
                  data = data, train = data_train, test = data_test)
save(result, file = "../output/mat_fac.RData")

# 3.Postprocessing
load(file = "../output/mat_fac.RData")
pred_rating <- t(result$q) %*% result$p
#define a function to extract the corresponding predictedrating for the test set.
extract_pred_rating <- function(test_set, pred){
  pred_rating <- pred[as.character(test_set[2]), as.character(test_set[1])]
  return(pred_rating)
}
#extract predicted rating
pred_test_rating <- apply(data_test, 1, extract_pred_rating, pred_rating)
#mean(P)
pred_mean <- mean(pred_test_rating)
#mean(test)
mean_test_rating <- mean(data_test$rating)
#mean(test) - mean(P)
mean_diff <- mean_test_rating - pred_mean
data_test$pred <- pred_test_rating
data_test$pred_adj <- pred_test_rating + mean_diff
boxplot(data_test$pred_adj ~ data_test$rating)
#calculate RMSE
rmse_adj <- sqrt(mean((data_test$rating - data_test$pred_adj)^2))
cat("The RMSE of the adjusted model is", rmse_adj)


# 4.evaluation
library(ggplot2)
RMSE <- data.frame(epochs = seq(10, 100, 10), Training_MSE = result$train_RMSE, Test_MSE = result$test_RMSE) %>% gather(key = train_or_test, value = RMSE, -epochs)
RMSE %>% ggplot(aes(x = epochs, y = RMSE,col = train_or_test)) + geom_point() + scale_x_discrete(limits = seq(10, 100, 10)) + xlim(c(0, 100))
