#### ---------- Summarize benchmark results----------- ####

suppressPackageStartupMessages({
    library(dplyr)
    library(magrittr)
    library(tidyr)
    library(optparse)
    library(stats)
    library(jsonlite)
    library(Matrix)
    library(R.utils)
})

### ------------------------------------------------------------------------------------------ ###
##  ---------------------------------------- Options ------------------------------------------ ##
### ------------------------------------------------------------------------------------------ ###

option_list = list(
  make_option(c("--info_files", type="character", default=NULL, 
              help="", metavar="character")),
  make_option(c("--res_files"), type="character", default=NULL, 
              help="", metavar="character"),
  make_option(c("--summary_parsed"), type="character", default=NULL, 
              help="", metavar="character")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

info_files <- opt$info_files
res_files <- opt$res_files
summary_parsed <- opt$summary_parsed

## Read result files
file_list <- jsonlite::read_json(res_files)
info_list <- unlist(jsonlite::read_json(info_files))

# Function to join parameter with NA for not set parameter
cbind.fill <- function(nm){
    nm <- lapply(nm, as.matrix)
    nam <- unique(unlist(as.vector(sapply(nm, rownames))))
    n <- length(nam)
    do.call(cbind, lapply(nm, function (x){
        mat <- matrix(data = NA, nrow = n, ncol = 1) %>% set_rownames(nam)
        mat[rownames(x),] <- x[,1]
        mat
    })) 
}

#Parameter dataframe
parameter_dat <- lapply(file_list, function(x){ 
    unlist(x)[grep("parameter.*", names(unlist(x)), value=TRUE)]
}) %>% cbind.fill() %>% t() %>% as.data.frame() %>% mutate("filename"=names(file_list))


sum_res <- function(metric_res_file){
    metric_res <- jsonlite::read_json(metric_res_file)
    summary <- data.frame(
        "metric_sum" = c(mean(unlist(metric_res))),
        "metric" = c(unlist(file_list[[metric_res_file]]$metric)),
        "dataset" = c(unlist(file_list[[metric_res_file]]$dataset)),
        "method" = c(unlist(file_list[[metric_res_file]]$method)) 
    )
}

# Result summary
summary_dat <- lapply(names(file_list), sum_res) %>% bind_rows() %>% mutate("filename"=names(file_list)) 
summary_all <- full_join(summary_dat, parameter_dat)

# Transform into wide format
summary_wide <- summary_all %>% 
                    unite("Method_Data_Param", c(method, dataset, contains("parameter")), remove = TRUE) %>%
                    pivot_wider(id_cols=c(Method_Data_Param), names_from=metric, values_from=metric_sum) %>%                                   mutate(across(2:ncol(.), ~replace(., lengths(.) == 0, NA)))

# remove duplicates
summary_wide[,-1] <- apply(summary_wide[,-1], 2, function(x){
    unlist(sapply(x,"[[",1))
})

# ID summary 
summary_id <- summary_all %>% 
                    unite("Method_Data_Param", c(method, dataset, contains("parameter")), remove = FALSE) %>%
                    select(c(Method_Data_Param, c(method, dataset, contains("parameter")))) %>% distinct()
                    

# Transform metric info files
info_res <- function(info_fi){
    metric_info <- jsonlite::read_json(info_fi)
    summary <- data.frame(
        "Metric"= c(unlist(metric_info$name)),
        "Group" = c(unlist(metric_info$group))
    )
}

info_summary <- lapply(info_list, info_res) %>% bind_rows()
# if discrpetency in naming between files, set default grouping
#if (!all(info_summary$Metric %in% colnames(summary_wide))){
#    info_summary <- data.frame("Metric" = colnames(summary_wide)[-c(1, #ncol(summary_wide))],
#                              "Group" = "default")
#    message("Warning: because of discreptencies, setting metric names to:\n", #info_summary$Metric)
#}

info_summary$Metric = colnames(summary_wide)[-1]

trans_res <- function(info_fi){
    metric_info <- jsonlite::read_json(info_fi)
    transform <- list(unlist(metric_info$flip))
    names(transform) <- "flip"
    transform
}

trans_list <- lapply(info_list, trans_res) %>% set_names(info_summary$metric[-length(info_summary)])

bettr_list <- list(
  df = summary_wide,
  idCol = "Method_Data_Param",
  initialTransforms = trans_list,
  metricInfo = info_summary,
  idInfo = summary_id
)


jsonlite::write_json(bettr_list, path = summary_parsed, 
                     pretty = TRUE, na = "string")


# DO NOT REMOVE
##########################################################################################
############### Define specific inputs for renku workflow tracking #######################
##########################################################################################

input_files <- c(names(file_list), unlist(info_list))
print(input_files)
#write(input_files, file=".renku/tmp/inputs.txt", append=TRUE)

sessionInfo()
