// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
using namespace Rcpp;

//' @name getLRT
//' @title Compute the LRT using Dutilleul (1999)'s Algorithm
//' @description This function implements Dutilleul (1999)'s Algorithm to obtain the likelihood ratio test statistic under normality. The null hypothesis is the separabiliy of covariance matrix, i.e. \eqn{\Sigma}=\code{U} \eqn{\otimes} \code{V}, and the alternative is not the null.
//' @param Y A r-by-(\code{p}*\code{q}) matrix where r is the sample size. See `Details' in \code{\link{Min_PermTest}} for its form.
//' @param p,q The number of rows and columns for matrix-variate data.
//' @param eps Tolerance constant for convergence. Default is 1e-10.
//' @param Mean The mean matrix of \code{Y}. Default is the sample mean vector for each row.
//' @return A list with components:
//' \item{lrt}{The LRT statistic.}
//' \item{U}{Row-wise covariance (p-by-p).}
//' \item{V}{Column-wise covariance (q-by-q).}
//' @references Dutilleul, P. (1999). The mle algorithm for the matrix normal distribution. \emph{Journal of Statistical Computation and Simulation}, \strong{64(2)}, 105-123.
//' @seealso \code{\link{Min_PermTest}}
//' @export
// [[Rcpp::export()]]
Rcpp::List getLRT_cpp(
    arma::mat Y, 
    int p, 
    int q, 
    double eps,
    arma::mat Mean
){
  double lrt;
  arma::mat U = arma::eye(p, p), U_new = U, V = arma::eye(q, q), V_new = V;
  int r = Y.n_rows;
  
  
  Y = Y - Mean;
  
  arma::mat Z = arma::zeros(pow(q, 2), pow(p, 2));
  
  for(int ii = 0; ii < r; ii++){
    arma::mat m = arma::reshape(Y.row(ii), q, p);
    Z = Z + arma::kron(m, m);
  }
  
  
  while(1){
    U_new = arma::reshape(Z.t() * arma::vectorise(inv(V)) / (q * r), p, p);
    V_new = arma::reshape(Z * arma::vectorise(inv(U_new)) / (p * r), q, q);
    
    if((arma::accu(arma::square(U_new - U)) < pow(eps, 2)) * (arma::accu(arma::square(V_new - V)) < pow(eps, 2))){
      break;
    }
    U = U_new;
    V = V_new;
  }
  
  
  lrt = r * q * log(arma::det(U)) + r * p * log(arma::det(V)) - r * log(arma::det(Y.t() * Y / r));
  
  return List::create(
    Named("lrt") = lrt,
    Named("U") = U,
    Named("V") = V                   
  );
}