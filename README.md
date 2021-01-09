
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NPCovSepTest

This is a README file of the R package *NPCovSepTest*. In our paper,
available
[here](https://link.springer.com/article/10.1007%2Fs00180-018-0839-2),
we test the separability of the covariance matrix by permutation-based
methods.

## Installation of the package

To install our package, you may simply execute the following codes:

``` r
# install.packages("devtools")
devtools::install_github("inmybrain/NPCovSepTest", subdir = "NPCovSepTest") # don't forget to specify subdir!
```

If you come across a problem like
[this](https://github.com/r-lib/remotes/issues/130), please refer to
[this
answer](https://github.com/r-lib/remotes/issues/130#issuecomment-423830669)
in that issue.

Or you can install the source file using the command line after
downloading it from
[here](https://drive.google.com/uc?export=download&id=17fDPoDeHPkezpFSpVUJllJr87KmFlNB8);

``` bash
R CMD INSTALL NPCovSepTest_2.0.tar.gz
```

## A basic example of using the package

We give a toy example to test the main functions `Min_PermTest`,
`Max_PermTest`, and `Twost_PermTest`. First, we generate \(20\) samples
from the multivariate Gaussian distribution with a separable covariance
matrix.

``` r
# install.packages("mvtnorm")
library("NPCovSepTest")
U <- matrix(c(1,0.5,0.5,1), nrow = 2)
V <- diag(rep(1,3))
set.seed(6)
Y <- mvtnorm::rmvnorm(20, sigma = U %x% V)

Min_PermTest(Y, 2, 3)
Max_PermTest(Y, 2, 3)
Twost_PermTest(Y, 2, 3)
```

All results indicate there is no strong evidence to reject the null,
i.e. separability of the covariance matrix.

## Notes

## Citation

To cite this package, please use this bibtex format:

``` latex
@article{Park:2019, 
  title = {Permutation based testing on covariance separability},
  DOI = {10.1007 / s00180 - 018 - 0839 - 2}, 
  journal = {Computational Statistics}, 
  author = {Park, Seongoh and Lim, Johan and Wang, Xinlei and Lee, Sanghan}, 
  year = {2019}, 
  volume = {34},
    number = {2},
    pages = {865–883}
}
```

## Issues

We are happy to troubleshoot any issue with the package;

  - please contact to the maintainer by <seongohpark6@gmail.com>, or

  - please open an issue in the github repository.

<!-- ## Error and warning messages you may get -->

<!-- ## References  -->
