#' @name Row_PermTest
#' @title Perform the row-wise permutation test.
#' @description The central function to test permutation tests.
#' @details See \code{\link{PermTest}} for arguments.
#' @import doRNG doMC foreach
#' @importFrom utils combn
#' @export
Row_PermTest <-
  function(Y, p, q, N_perm = 2000, center = F, scale = T, n_cluster = 1){
    registerDoMC(n_cluster)
    r <- nrow(Y)
    Y_rescale <- scale(Y, center = center, scale = scale)
    RowPair <- as.data.frame(combn(p, 2))
    Perm_pvalue <- lapply(RowPair, function(pair){
      idx_i <- (q * (pair[1] - 1) + 1):(q * pair[1])
      idx_j <- (q * (pair[2] - 1) + 1):(q * pair[2])
      Y_ij <- Y_rescale[,c(idx_i, idx_j)] 
      lrt_ij <- getLRT(Y_ij, q, 2, Mean = matrix(0, nrow = nrow(Y_ij), ncol = ncol(Y_ij)))$lrt
      suppressWarnings(
        Perm_lrt <- foreach(noarg = 1:N_perm, .combine = "c", 
                            .export = c("PermY", "getLRT", "Y_ij", "q")) %dorng%
                            {
                              PY_ij <- PermY(Y_ij)
                              return(getLRT(PY_ij, q, 2, Mean = matrix(0, nrow = nrow(PY_ij), ncol = ncol(PY_ij)))$lrt)
                            }
      )
      Perm_pvalue <- mean(unlist(Perm_lrt) > lrt_ij)
      return(Perm_pvalue)
    })
    pvalue <- min(min(unlist(Perm_pvalue)) * ncol(RowPair), 1) # Bonferroni correction
    return(pvalue)
  }