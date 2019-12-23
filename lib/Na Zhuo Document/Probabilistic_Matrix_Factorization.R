#Define a function to calculate RMSE
RMSE <- function(rating, est_rating){
  sqr_err <- function(obs){
    sqr_error <- (obs[3] - est_rating[as.character(obs[2]), as.character(obs[1])])^2
    return(sqr_error)
  }
  return(sqrt(mean(apply(rating, 1, sqr_err))))  
}

#Stochastic Gradient Descent
# a function returns a list containing factorized matrices p and q, training and testing RMSEs.
# f: number of latent factor
# U: number of users
# V: number of movies
# sigma, sigma_p, sigma_q, 
probgradesc <- function(f = 10, U=610, V=9724, 
                        sigma=0.01, sigma_q=0.1, sigma_p=0.1,
                        lrate = 0.01, 
                        max.iter, 
                        stopping.deriv = 0.01,
                        data, train, test)
{
  set.seed(0)
  #random assign value to matrix p and q
  p <- matrix(runif(f*U, -1, 1), ncol = U) 
  colnames(p) <- as.character(1:U)
  q <- matrix(runif(f*V, -1, 1), ncol = V)
  colnames(q) <- levels(as.factor(data$movieId))
  
  train_RMSE <- c()
  test_RMSE <- c()
  
  for(l in 1:max.iter){
    #loop through each training case and perform update
    sample_idx <- sample(1:nrow(train), nrow(train))
    for (s in sample_idx){
      # user id
      u <- as.character(train[s,1])
      # movie id
      i <- as.character(train[s,2])
      # rating
      r_ui <- train[s,3]
      
      # (r-qp)
      e_ui <- r_ui - t(q[,i]) %*% p[,u]
      
      # gradient of q
      grad_q <- e_ui %*% p[,u] -  (sigma/sigma_q) * q[,i]
      if (all(abs(grad_q) > stopping.deriv, na.rm = T)){
        q[,i] <- q[,i] + lrate * grad_q
      }
      
      # gradient of p
      grad_p <- e_ui %*% q[,i] - (sigma/sigma_p) * p[,u]
      if (all(abs(grad_p) > stopping.deriv, na.rm = T)){
        p[,u] <- p[,u] + lrate * grad_p
      }
    }
    #print the values of training and testing RMSE
    if (l %% 10 == 0){
      cat("epoch:", l, "\t")
      est_rating <- t(q) %*% p
      rownames(est_rating) <- levels(as.factor(data$movieId))
      
      train_RMSE_cur <- RMSE(train, est_rating)
      cat("training RMSE:", train_RMSE_cur, "\t")
      train_RMSE <- c(train_RMSE, train_RMSE_cur)
      
      test_RMSE_cur <- RMSE(test, est_rating)
      cat("test RMSE:",test_RMSE_cur, "\n")
      test_RMSE <- c(test_RMSE, test_RMSE_cur)
    } 
  }
  
  return(list(p = p, q = q, train_RMSE = train_RMSE, test_RMSE = test_RMSE))
}
