#' @name getLRT
#' @description \code{\link{getLRT}} is an wrapper function for \code{\link{getLRT_cpp}} to set default parameters.
#' @examples
#' U <- diag(rep(1,2))
#' V <- diag(rep(1,3))
#' set.seed(6)
#' Y <- mvtnorm::rmvnorm(50, sigma = U %x% V)
#' getLRT(Y, 2, 3)$lrt
#' @export
getLRT <-
  function(Y, p, q, eps = 1e-10, Mean = rep(1, nrow(Y)) %x% matrix(colMeans(Y), nrow = 1)){
    return(getLRT_cpp(Y = Y, p = p, q = q, eps = eps, Mean = Mean))
}
