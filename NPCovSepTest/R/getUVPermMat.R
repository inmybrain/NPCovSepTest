#' @name getUVPermMat
#' @title Generate a permutation matrix to ensure transition from row-wise permutation to column-wise.
#' @description This function generates a permutation matrix P that rearranges a vector of \eqn{[(Y_{11}, ..., Y_{1q}, Y_{21}, ..., Y_{2q}, ..., Y_{pq})]}.
#' Here, row and column are inherited from the matrix form of it. If P is left-multiplied to the vector, the reordered vector is \eqn{[(Y_{11}, ..., Y_{p1}, Y_{12}, ..., Y_{p2}, ..., Y_{pq})]}.
#' @param p,q The number of rows and columns for matrix-variate data.
#' @return A binary matrix for permutation purpose.
#' @examples
#' Y <- matrix(1:6, 2, 3, byrow = TRUE) # Imagine this is a matrix-variate data
#' vecY <- matrix(t(Y), ncol = 1) # identical with c(1,2,3,4,5,6)
#' P <- getUVPermMat(2, 3)
#' P %*% vecY # identical with c(1,4,2,5,3,6)
#' @export
getUVPermMat <-
function(p, q){
  P <- diag(0, p * q)
  iden <- diag(1, p * q)
  for(j in 1:q){
    P[((j - 1) * p + 1):(j * p),] <- iden[seq(j, p * q, by = q),]
  }
  return(P)
}
