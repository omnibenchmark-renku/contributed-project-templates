#### ---------- Harmony method ----------- #### 
## Short Description:
# The Harmony algorithm initializes all datasets in PCA space along with the batch variable and                             
# alternately iterates over two complementary concepts until convergence. First, it employs                     
# maximum diversity clustering, which penalizes overcorrection and pushes clusters with the                     
# same cells apart. Second, batch effects are accounted for by a linear mixture model. 
# Thus, Harmony returns a corrected embedding.(From Luecken et al., 2020)


args <- (commandArgs(trailingOnly = TRUE))
for (i in seq_len(length(args))) {
    eval(parse(text = args[[i]]))
}

print(out_path)
print(count_file)
print(meta_file)
print(dataset_name)

#print(k)
#print(d)
#print(lambda)

#Define default parameter
k <- 30
d <- 20
lambda <- 1

## Libraries
library(harmony)
library(jsonlite)
library(Matrix)
library(R.utils)
library(magrittr)
library(dplyr)

set.seed(1234)

## Load data
norm <- readMM(count_file)
meta <- fromJSON(meta_file)
colnames(norm) <- meta$cell_id 

#get parameter
param_vec <- paste(d, k, lambda, sep = "_")

sigma <-  0.1/30 * as.numeric(k)


## run harmony
if( k == 30 & d == 20 & lambda == 1 ){
    param_vec <- paste0(param_vec, "_default")
}
    
harmony_out <- HarmonyMatrix(as.matrix(norm), meta, vars_use = "batch_id", 
                             npcs = d, sigma = sigma, lambda = lambda)


## Save reduced representation as gziped mtx
red_mtx <- as.matrix(harmony_out)
red_mtx <- Matrix(red_mtx)
red_mtx <- as(red_mtx, "dgTMatrix")
red_out <- paste0(out_path, "/", "harmony_", dataset_name,"_", param_vec, "_red_dim.mtx")
writeMM(obj = red_mtx, red_out)
gzip(red_out, overwrite=TRUE)

sessionInfo()