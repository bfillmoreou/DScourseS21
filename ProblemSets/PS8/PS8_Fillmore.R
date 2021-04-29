<<<<<<< HEAD
library(nloptr)
library(modelsummary)

set.seed(100)

N     = 100000
K     = 10
sigma = .5


X    <- matrix(rnorm(N*K, mean = 0, sd = sigma), N, K)
X[,1] <- 1
eps  <-rnorm(N, mean = 0, sd = sigma)
beta <- c(1.5, -1, -0.25, 0.75, 3.5, -2, 0.5, 1, 1.25, 2)

y <- X%*%beta + eps

estimates <- lm(y~X -1)
print(summary(estimates))


# set up a stepsize
step.size <- 0.0000003
# set up a number of iteration
iter <- 500
# define the gradient of f(x) = x^4 - 3*x^3 + 2
gradient <- function(X) return((4*X^3) - (9*X^2))
# randomly initialize a value to x
# create a vector to contain all xs for all steps
X.All <- vector("numeric",iter)
# gradient descent method to find the minimum
for(i in 1:iter){
  X <- X - step.size*gradient(X)
  X.All[i] <- X
}
# print result and plot all xs for every iteration
print(head(paste("The minimum of f(x) is ", X, sep = "")))


# L-BFGS
# Our objective function
eval_f <- function(x) {
  return( x[1]^4 - 3*x[1]^3 + 2 )
}
# Gradient of our objective function
eval_grad_f <- function(x) {
  return( 4*x[1]^3 - 9*x[1]^2 )
}
# initial values
x0 <- -5
# Algorithm parameters
opts <- list("algorithm"="NLOPT_LD_LBFGS","xtol_rel"=1.0e-8)
# Find the optimum!
res_lbfgs <- nloptr( x0=x0,eval_f=eval_f,eval_grad_f=eval_grad_f,opts=opts)
print(res_lbfgs)


# Nelder-Mead
# Our objective function
objfun <- function(x) {
  return( x[1]^4 - 3*x[1]^3 + 2 )
}
# initial values
xstart <- 5
# Algorithm parameters
options <- list("algorithm"="NLOPT_LN_NELDERMEAD","xtol_rel"=1.0e-8)
# Find the optimum!
res_nead <- nloptr( x0=xstart,eval_f=objfun,opts=options)
print(res_nead)

gradient <- function(theta,Y,X) {
  grad <- as.vector(rep(o, length(theta)))
  beta <- theta[1:(length(theta)-1)]
  sig  <- theta[length(theta)]
  grad[1:(length(theta)-1)] <- -t(X)%*%(Y-X%*%beta)/(sig^2)
  grad[length(theta)]<-dim(X)[1]/sig-crossprod(Y-X%*% beta)/(sig^3)
  return(gradient)
}


modelsummary(list(estimates), output = ".tex")
=======
library(nloptr)
library(modelsummary)

set.seed(100)

N     = 100000
K     = 10
sigma = .5


X    <- matrix(rnorm(N*K, mean = 0, sd = sigma), N, K)
X[,1] <- 1
eps  <-rnorm(N, mean = 0, sd = sigma)
beta <- c(1.5, -1, -0.25, 0.75, 3.5, -2, 0.5, 1, 1.25, 2)

y <- X%*%beta + eps

estimates <- lm(y~X -1)
print(summary(estimates))


# set up a stepsize
step.size <- 0.0000003
# set up a number of iteration
iter <- 500
# define the gradient of f(x) = x^4 - 3*x^3 + 2
gradient <- function(X) return((4*X^3) - (9*X^2))
# randomly initialize a value to x
# create a vector to contain all xs for all steps
X.All <- vector("numeric",iter)
# gradient descent method to find the minimum
for(i in 1:iter){
  X <- X - step.size*gradient(X)
  X.All[i] <- X
}
# print result and plot all xs for every iteration
print(head(paste("The minimum of f(x) is ", X, sep = "")))


# L-BFGS
# Our objective function
eval_f <- function(x) {
  return( x[1]^4 - 3*x[1]^3 + 2 )
}
# Gradient of our objective function
eval_grad_f <- function(x) {
  return( 4*x[1]^3 - 9*x[1]^2 )
}
# initial values
x0 <- -5
# Algorithm parameters
opts <- list("algorithm"="NLOPT_LD_LBFGS","xtol_rel"=1.0e-8)
# Find the optimum!
res_lbfgs <- nloptr( x0=x0,eval_f=eval_f,eval_grad_f=eval_grad_f,opts=opts)
print(res_lbfgs)


# Nelder-Mead
# Our objective function
objfun <- function(x) {
  return( x[1]^4 - 3*x[1]^3 + 2 )
}
# initial values
xstart <- 5
# Algorithm parameters
options <- list("algorithm"="NLOPT_LN_NELDERMEAD","xtol_rel"=1.0e-8)
# Find the optimum!
res_nead <- nloptr( x0=xstart,eval_f=objfun,opts=options)
print(res_nead)

gradient <- function(theta,Y,X) {
  grad <- as.vector(rep(o, length(theta)))
  beta <- theta[1:(length(theta)-1)]
  sig  <- theta[length(theta)]
  grad[1:(length(theta)-1)] <- -t(X)%*%(Y-X%*%beta)/(sig^2)
  grad[length(theta)]<-dim(X)[1]/sig-crossprod(Y-X%*% beta)/(sig^3)
  return(gradient)
}


modelsummary(estimates, output = ".tex")
>>>>>>> ed7f034c209b8f8304b07632c75e3e7d2863e5c8
