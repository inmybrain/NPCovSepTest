#' @name PermTest
#' @title Perform the permutation tests.
#' @description The main functions for permutation tests. \code{Min_PermTest} conducts permutation along the smaller side (either row or column), and \code{Max_PermTest} along the larger side. \code{Twost_PermTest} combines two functions using two-stage addtive method (Sheng and  Qiu (2007)). Three functions are mainly based on \code{Row_PermTest}.
#' @param Y A r-by-(\code{p}*\code{q}) matrix where r is the sample size. See `Details' for its form.
#' @param p,q The number of rows and columns for matrix-variate data.
#' @param N_perm The number of permutations. Default is 2000.
#' @param center,scale Logical; to center and scale each column or not. This argument will be passed to \link[base]{scale}. Default is FALSE for \code{center} and TRUE for \code{scale}.
#' @param n_cluster The number of cores to be used in parallel computing. Default is 1. 
#' @param level The aimed significance level of test, only applicable to \code{Twost_PermTest}. Default is 0.05.
#' @return The p-value from the permutation test.
#' @details Note that parallel computation based on \code{\link{doMC}} package is not supported in Window operating system. For the two-stage method, \code{Twost_PermTest} does \code{Min_PermTest} first. If it returns p-value smaller than \eqn{\gamma=1-\sqrt{1-\code{level}}}, then stop. Otherwise, \code{Max_PermTest} is executed, and the combined p-value is \eqn{\gamma + (1-\gamma)p} where \eqn{p} is the p-value from \code{Max_PermTest}. \cr
#' To describe the order of columns in \code{Y}, let \eqn{Z_1, \ldots, Z_r} be \code{p}-by-\code{q} matrix variate data used to test separability. Then, the \eqn{i}th row of \code{Y} (\code{p}\code{q}-by-1) is obtained by stacking the rows of \eqn{Z_i}.
#' @examples
#' U <- matrix(c(1,0.5,0.5,1), nrow = 2)
#' V <- diag(rep(1,3))
#' set.seed(6)
#' Y <- mvtnorm::rmvnorm(20, sigma = U %x% V)
#' \donttest{
#' Min_PermTest(Y, 2, 3)
#' Max_PermTest(Y, 2, 3)
#' Twost_PermTest(Y, 2, 3)
#' }
#' @references Sheng, J. and Qiu, P. (2007). p-Value calculation for multi-stage additive tests. \emph{Journal of Statistical Computation and Simulation}, \strong{77(12)}, 1057-1064.
#' @export
Min_PermTest <-
function(Y, p, q, N_perm = 2000, center = F, scale = T, n_cluster = 1){
  if(p <= q){
    pvalue <- Row_PermTest(Y = Y, p = p, q = q, N_perm = N_perm, center = center, scale = scale, n_cluster = n_cluster)
  } else{
    P <- getUVPermMat(p, q)
    Y <- Y %*% t(P)
    pvalue <- Row_PermTest(Y = Y, p = q, q = p, N_perm = N_perm, center = center, scale = scale, n_cluster = n_cluster)
  }
  return(pvalue)
}
