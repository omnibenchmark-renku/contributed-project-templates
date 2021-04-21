#### ----------  dataset import ----------- #### 
suppressPackageStartupMessages({
  library("BiocManager")
  library('SingleCellExperiment')
  library('jsonlite')
  library('Matrix')
  library("R.utils")
})

args <- (commandArgs(trailingOnly = TRUE))
for (i in seq_len(length(args))) {
  eval(parse(text = args[[i]]))
}

print(out_path)
print(dataset_name)

## Dataset info file
## Json file should have AT LEAST the following information
## link, tissue, n_cells, n_genes (added automatically latter), description
info_list <- list(
    "link" = "link to study",
    "tissue" = "tissue",
    "description" = "A complete description about the experimental design,\n
                     for e.g. the treatment, condition, specificities, etc.", 
    "note" = "Any comment on the importance of this dataset for the benchmark,\n
              e.g., 'example of unbalanced sample sizes'."
)

### -------------------------------------------- ###
## ------------ Format the data ----------------- ##
### -------------------------------------------- ###

#############
# YOUR CODE #
#############

# Example of how the data can look like
source("src/utils/r_utils.R")
sce <- dummy_data()

# Check that the data are in the correct form
check_input_data(dat_counts = counts(sce), 
                 meta_features = as.data.frame(rowData(sce)), 
                 meta_cells = as.data.frame(colData(sce)))

## The lasts steps should always be in this form:
# Save counts as gziped mtx
matrix_out <- paste0(out_path, "/counts_", dataset_name, ".mtx")
writeMM(obj = counts(sce), matrix_out)
gzip(matrix_out, overwrite=TRUE)

# save cell and features meta
jsonlite::write_json(as.data.frame(colData(sce)), paste0(out_path, "/meta_", dataset_name, ".json"), 
                     matrix = "columnmajor")

jsonlite::write_json(as.data.frame(rowData(sce)), paste0(out_path, "/feature_", dataset_name, ".json"), 
                     matrix = "columnmajor")

# Adding final infos
info_list$n_cells <- ncol(sce)
info_list$n_genes <- nrow(sce)

jsonlite::write_json(info_list, paste0(out_path, "/data_info_", dataset_name, ".json"))

sessionInfo()
