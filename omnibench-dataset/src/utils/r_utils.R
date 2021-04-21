# Basic R packages to load and save datasets

suppressPackageStartupMessages({
  library("BiocManager")
  library('SingleCellExperiment')
  library('jsonlite')
  library('Matrix')
  library("R.utils")
})

dummy_data <- function(ncells = 200, write_data = FALSE, out_path = "data/dummy", dataset_name = "dummy" ){
  
  colData <- data.frame(barcodes = paste0("BC-", 1:ncells), 
                        sample = rep(c("A", "B"), each = ncells/2), 
                        row.names = paste0("BC-", 1:ncells))
  sce <- SingleCellExperiment(assays=list(counts= Matrix(matrix(rpois(20000, 1), ncol=ncells), sparse =TRUE)), 
                              colData = colData, 
                              rowData = data.frame("gene_id"=paste0("ENS", 1:(20000/ncells))))
  rownames(sce) <- rowData(sce)[,1]
  
  
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

check_input_data <- function(dat_counts, meta_features, meta_cells){
  
  # Dims
  if (!nrow(meta_features) == nrow(dat_counts)) stop("The numbers of features in counts and metadata are not the same.")
  if (!nrow(meta_cells) == ncol(dat_counts)) stop("The numbers of cells in counts and metadata are not the same.")
  
  # Format
  if (!is.data.frame(meta_features)) stop("The features metadata is not a data.frame.")
  if (!is.data.frame(meta_cells)) stop("The cells metadata is not a data.frame.")
  if (!is(dat_counts, "dgCMatrix")) stop("The counts are not in a sparse matrix format.")
  
  # Naming
  if (!all(grepl("^ENS", meta_features[,1]))) stop("The features metadata is not a data.frame.")
  if (TRUE %in% duplicated(meta_features[,1])) stop("There are duplicated IDs in the features metadata.")
  if (TRUE %in% duplicated(meta_cells[,1])) stop("There are duplicated barcodes in the cell metadata.")
  

}




