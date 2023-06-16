
install.packages("BiocManager")

BiocManager::install(version = "3.8")

install.packages('https://cran.r-project.org/src/contrib/Archive/getopt/getopt_1.20.2.tar.gz')
install.packages("https://cran.r-project.org/src/contrib/Archive/optparse/optparse_1.6.0.tar.gz")

install.packages("remotes")
remotes::install_version("styler", version = "1.0.1")
remotes::install_version("usethis", version = "1.3.0")
remotes::install_version("devtools", version = "1.13.5")

BiocManager::install('SingleCellExperiment')
BiocManager::install('jsonlite')
BiocManager::install('Matrix')

install.packages("dplyr")
install.packages("magrittr")

install.packages("https://cran.r-project.org/src/contrib/Archive/locfit/locfit_1.5-9.1.tar.gz", repos=NULL, dependencies = TRUE)

remotes::install_version("RcppAnnoy", version = "0.0.16")

bioconductor_packages <- c("BiocParallel", "BiocGenerics",
                           "SingleCellExperiment", "GenomeInfoDb", 
                           "GenomeInfoDbData", "BiocNeighbors")
BiocManager::install(bioconductor_packages)

## BiocManager::install('https://code.bioconductor.org/browse/scran/tarball/RELEASE_3_8/scran_release_3_8.tar')
BiocManager::install('scran')

install.packages("R.utils")
install.packages("optparse")
