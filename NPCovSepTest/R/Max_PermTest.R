#' @name PermTest
#' @export
Max_PermTest <-
function(Y, p, q, N_perm = 2000, center = F, scale = T, n_cluster = 1){
  if(p > q){
    pvalue <- Row_PermTest(Y = Y, p = p, q = q, N_perm = N_perm, center = center, scale = scale, n_cluster = n_cluster)
  } else{
    P <- getUVPermMat(p, q)
    Y <- Y %*% t(P)
    pvalue <- Row_PermTest(Y = Y, p = q, q = p, N_perm = N_perm, center = center, scale = scale, n_cluster = n_cluster)
  }
  return(pvalue)
}
