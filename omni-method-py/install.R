install.packages("BiocManager")
install.packages("optparse")
install.packages("https://cran.rstudio.com/src/contrib/matrixStats_0.58.0.tar.gz", repo=NULL, type="source")

pkgs <- c("batchelor","SingleCellExperiment",
          "jsonlite","Matrix",
          "dplyr","magrittr","R.utils")

BiocManager::install(pkgs)