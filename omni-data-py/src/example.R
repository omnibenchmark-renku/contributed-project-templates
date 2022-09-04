### ----------------------------------------------------------------- ###
##  ------------------------ Dataset      ---------------------------  ##
### ----------------------------------------------------------------- ###

# Some description about the dataset

### ----------------------------------------------------------------- ###
##  ------------------------- Libraries -----------------------------  ##
### ----------------------------------------------------------------- ###

library(utils)
library(SingleCellExperiment)
library(jsonlite)
library(Matrix)
library(R.utils)
library(optparse)

set.seed(1000)


### ----------------------------------------------------------------- ###
##  ------------------------- Options -------------------------------  ##
### ----------------------------------------------------------------- ###

# These are example options. Feel free to modify it for your dataset. 
option_list <- list(
    make_option(c("--data_info"), type = "character", default = NULL,
                help = "Path to file with general information"),
    make_option(c("--counts"), type = "character", default = NULL,
                help = "Path to count file (cells as columns, genes as rows)"),
    make_option(c("--meta"), type = "character", default = NULL,
                help = "Path to file with meta data infos"),
    make_option(c("--feature"), type = "character", default = NULL,
                help = "Path to feature file")
);
 
opt_parser <- OptionParser(option_list = option_list);
opt <- parse_args(opt_parser);

if (is.null(opt$counts) || is.null(opt$data_info) || is.null(opt$meta) || is.null(opt$feature)) {
      print_help(opt_parser)
  stop("Please specify a path to store the counts, meta data, data infos and features.",
        call. = FALSE)
}

count_file <- gsub(".gz$", "", opt$counts)
meta_file <- opt$meta
data_info_file <- opt$data_info
feature_file <- opt$feature

### ----------------------------------------------------------------- ###
##  ---------------------------- Data -------------------------------  ##
### ----------------------------------------------------------------- ###



#### ----------  dataset import ----------- #### 

## Dataset info file
# The dataset json file should have AT LEAST the following information
# link, tissue, n_cells, n_genes (added automatically latter), description
info_list <- list(
  {% if study_link %}
   "link" = "{{ study_link }}", 
  {% else %}
  "link" = "link to study",
  {% endif %}
  {% if study_tissue %}
  "tissue" = "{{ study_tissue }}",
  {% else %}
  "tissue" = "tissue",
  {% endif %}
  {% if metadata_description %}
  "description" = "{{ metadata_description }}",
  {% else %}
  "description" = "A complete description of the experimental design, for e.g. the treatment, condition, specificities, etc.",
  {% endif %}
  {% if study_note %}
  "note" = "{{ study_note }}"
  {% else %}
  "note" = "Any comment on the importance of this dataset for the benchmark,e.g., 'example of unbalanced sample sizes'."
  {% endif %}
)


### -------------------------------------------- ###
## ------------ Format the data ----------------- ##
### -------------------------------------------- ###

#############
# YOUR CODE #
#############
# ...
# WARNING: the output files and their extensions should also 
# match the entries in your config.yaml file (outputs -- files).



#################
# EXAMPLE CODE #
#################

# Example of how the data can look like:
source("src/r_utils.R")
(sce <- dummy_data())
# you can also check how the data files should look like: 
# sce <- dummy_data(write_data = TRUE)

# Once you added your code, check that the data are in the correct form:
check_input_data(dat_counts = counts(sce), 
                 meta_features = as.data.frame(rowData(sce)), 
                 meta_cells = as.data.frame(colData(sce)))

# The lasts steps could typically be in this form:
# 1. Save counts as gziped mtx
mtx <- as.matrix(counts(sce))
sparse_mtx <- Matrix(mtx, sparse = TRUE)
writeMM(obj = sparse_mtx, count_file)
gzip(count_file, overwrite = TRUE)

# 2. Save meta data file 
# gziped csv with batch_id, cluster_id as colnames and cells as rownames
meta <- data.frame("batch_id" = sce$sample,
                  "cluster_id" = sce$ident,
                  "cell_id" = colnames(sce))

jsonlite::write_json(meta, meta_file, 
                     matrix = "columnmajor")

# 3. Save gene info file
gene_info <- data.frame("gene_id" = rownames(sce))
jsonlite::write_json(gene_info, feature_file,
                     matrix = "columnmajor")

# 4. Dataset info file (optional)
# Json file with the following variables: 
# url, tissue, n_cells, n_genes, n_cluster, n_batches, description
info_list <- list(
    "url" = info_list$study_link,
    "tissue" = info_list$study_tissue,
    "n_cells" = ncol(sce),
    "n_genes" = nrow(sce),
    "n_cluster" = length(levels(as.factor(sce$ident))),
    "n_batches" = length(levels(as.factor(sce$sample))),
    "description" = info_list$study_note,
    "update" = "FALSE"
)

jsonlite::write_json(info_list, data_info_file)

sessionInfo()




