#' @name PermY
#' @title Perform random permutation of each row in \code{Y}
#' @description This function permutes two vectors in every rows depending on randomness. Therefore, permutation will be conducted as many as the number of rows.
#' @param Y A matrix. See `Details' for its form.
#' @return The permuted matrix.
#' @details For \code{Y}, each row is combined of two vectors to be permuted. In other words, the first half and the other half of a row would be exchanged with probability 1/2.
#' @examples
#' set.seed(6)
#' matrix(rep(c(1,1,1,2,2,2), 6), nrow = 6, byrow = TRUE)
#' PermY(matrix(rep(c(1,1,1,2,2,2), 6), nrow = 6, byrow = TRUE))
#' @importFrom stats runif
#' @export
PermY <-
function(Y){
  idx_permute <- which((runif(nrow(Y)) < 1/2))
  idx_i <- 1:(ncol(Y) / 2)
  idx_j <- (ncol(Y) / 2 + 1):ncol(Y)
  Y[idx_permute, c(idx_i, idx_j)] <- Y[idx_permute, c(idx_j, idx_i)]
  return(Y)
}
