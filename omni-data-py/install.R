
#install optparse 
install.packages('https://cran.r-project.org/src/contrib/Archive/getopt/getopt_1.20.2.tar.gz')
install.packages("https://cran.r-project.org/src/contrib/Archive/optparse/optparse_1.6.0.tar.gz")


# install Bioc
install.packages("BiocManager")
BiocManager::install(version = "3.8")

# install project dependencies
BiocManager::install('SingleCellExperiment')
BiocManager::install('DuoClustering2018')
BiocManager::install('jsonlite')
BiocManager::install('Matrix')
BiocManager::install("R.utils")
