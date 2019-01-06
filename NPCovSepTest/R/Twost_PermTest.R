#' @name PermTest
#' @export
Twost_PermTest <-
function(Y, p, q, N_perm = 2000, center = F, scale = T, level = 0.05, n_cluster = 1){
  gamma <- 1 - sqrt(1 - level)
  # Stage 1
  pvalue <- Min_PermTest(Y = Y, p = p, q = q, N_perm = N_perm, center = center, scale = scale, n_cluster = n_cluster)
  if(pvalue >= gamma){
    # Stage 2
    pvalue <- gamma + (1 - gamma) * Max_PermTest(Y = Y, p = p, q = q, N_perm = N_perm, center = center, scale = scale, n_cluster = n_cluster)
  }
  return(pvalue)
}
