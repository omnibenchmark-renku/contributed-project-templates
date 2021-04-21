# Basic R packages to load and save datasets

suppressPackageStartupMessages({
  library("BiocManager")
  library('SingleCellExperiment')
  library('jsonlite')
  library('Matrix')
  library("R.utils")
})

dummy_data <- function(ncells = 200, write_data = FALSE, out_path = "data/dummy", dataset_name = "dummy" ){
  
  colData <- data.frame(sample = rep(c("A", "B"), each = ncells/2), 
                        row.names = paste0("BC-", 1:ncells))
  sce <- SingleCellExperiment(assays=list(counts=matrix(rpois(20000, 1), ncol=ncells)), 
                              colData = colData)
  rownames(sce) <- paste0("ENS", 1:nrow(sce))
  
  if (write_data == TRUE) {
    
    mtx <- as.matrix(counts(sce))
    sparse_mtx <- Matrix(mtx , sparse = T)
    
    matrix_out <- paste0(out_path, "/counts_", dataset_name, ".mtx")
    writeMM(obj = sparse_mtx, matrix_out)
    gzip(matrix_out, overwrite=TRUE)
    
    gene_info <- data.frame("gene_id" = rownames(sce))
    jsonlite::write_json(gene_info,  paste0(out_path, "/feature_", dataset_name, ".json"), 
                         matrix = "columnmajor")
    
    jsonlite::write_json(as.data.frame(colData(sce)),  paste0(out_path, "/meta_", dataset_name, ".json"), 
                         matrix = "columnmajor")
  } 
  return(sce)

}


