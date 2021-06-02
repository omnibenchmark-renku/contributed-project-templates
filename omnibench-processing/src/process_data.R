
# Author: Almut Luetge, Anthony Sonrel

### ---------- Normalization and preprocessing ----------- #### 
  
args <- (commandArgs(trailingOnly = TRUE))
for (i in seq_len(length(args))) {
    eval(parse(text = args[[i]]))
}

set.seed(1234)

## Input Arguments
print(count_file)
print(meta_file)
print(dataset_name)
print(out_path)

## Libraries
library(utils)
library(SingleCellExperiment)
library(scater)
library(scran)
library(R.utils)
library(Matrix)
library(jsonlite)
library(uwot)

## Load data
counts <- readMM(count_file)
meta <- fromJSON(meta_file)
colnames(counts) <- meta$cell_id 

## Generate sce
sce <- SingleCellExperiment(list(counts = counts),
                                 colData = DataFrame(meta))


## Normalize 
clusters <- quickCluster(sce, use.ranks=FALSE)
table(clusters)
sce <- computeSumFactors(sce, min.mean=0.1, cluster=clusters)
sce <-  logNormCounts(sce)


## Select highly variable genes
dec <- modelGeneVar(sce)
dec <- dec[order(dec$bio, decreasing = TRUE),] 
hvg_sig <- getTopHVGs(dec, fdr.threshold=0.05)
hvg <- getTopHVGs(dec, var.threshold = 0)
length(hvg)
length(hvg_sig)
hvg_tab <- data.frame("all" = hvg,
                      "sig" = hvg %in% hvg_sig)


## Run dimensional reduction
sce <- runPCA(sce, ncomponents = 20, ntop = length(hvg))
sce <- runUMAP(sce)


## Save normalized counts as gziped mtx file
mtx <- as.matrix(logcounts(sce))
mtx <- Matrix(mtx)
mtx <- as(mtx, "dgTMatrix")
matrix_out <- paste0(out_path, "/norm_counts_", dataset_name, ".mtx")
writeMM(obj = mtx, matrix_out)
gzip(matrix_out, overwrite=TRUE)



## Save reduced Dimensions as gziped mtx
colnames(reducedDims(sce)[["UMAP"]]) <- c("UMAP1", "UMAP2")
red_tab <- cbind(reducedDims(sce)[["PCA"]], reducedDims(sce)[["UMAP"]])
red_mtx <- as.matrix(red_tab)
red_mtx <- Matrix(red_mtx)
red_mtx <- as(red_mtx, "dgTMatrix")
red_out <- paste0(out_path, "/dim_red_", dataset_name, ".mtx")
writeMM(obj = red_mtx, red_out)
gzip(red_out, overwrite=TRUE)


## Save highly variable genes as json
jsonlite::write_json(hvg_tab, paste0(out_path, "/hvg_", dataset_name, ".json"), 
                     matrix = "columnmajor")

sessionInfo()
