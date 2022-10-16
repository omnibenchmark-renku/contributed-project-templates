#### ---------- Summarize benchmark results----------- ####

## Summarize result per dataset by using the overall mean
args <- (commandArgs(trailingOnly = TRUE))
for (i in seq_len(length(args))) {
    eval(parse(text = args[[i]]))
}

#print(out_path)
print(info_files)
print(res_files)
print(out_path)
print(out_name)

## Libraries
library(jsonlite)
library(dplyr)
library(magrittr)
library(tidyr)

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
        "method" = c(unlist(file_list[[metric_res_file]]$method)), 
        "runtime" = c(unlist(file_list[[metric_res_file]]$runtime))
    )
}

# Result summary
summary_dat <- lapply(names(file_list), sum_res) %>% bind_rows() %>% mutate("filename"=names(file_list)) 
summary_all <- full_join(summary_dat, parameter_dat)
summary_runtime <- summary_all[summary_all$metric %in% summary_all$metric[1], ]
summary_all <- rbind(select(summary_all, -runtime), 
                     cbind(data.frame("metric_sum" = summary_runtime$runtime, 
                                "metric" = "runtime"), 
                           select(summary_runtime, -c("metric_sum", "metric", "runtime"))))

# Transform into wide format
summary_wide <- summary_all %>% 
                    unite("Method_Data_Param", c(method, dataset, contains("parameter")), remove = TRUE) %>%
                    pivot_wider(id_cols=c(Method_Data_Param), names_from=metric, values_from=metric_sum)

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
if (!all(info_summary$Metric %in% colnames(summary_wide))){
    info_summary <- data.frame("Metric" = colnames(summary_wide)[-c(1, ncol(summary_wide))],
                              "Group" = "default")
    message("Warning: because of discreptencies, setting metric names to:\n", info_summary$Metric)
}
info_summary <- rbind(info_summary, c("runtime", "secondary"))

trans_res <- function(info_fi){
    metric_info <- jsonlite::read_json(info_fi)
    transform <- list(unlist(metric_info$flip))
    names(transform) <- "flip"
    transform
}

trans_list <- lapply(info_list, trans_res) %>% set_names(info_summary$metric[-length(info_summary)])
trans_list$runtime$flip = 'FALSE'

bettr_list <- list(
  df = summary_wide,
  idCol = "Method_Data_Param",
  initialTransforms = trans_list,
  metricInfo = info_summary,
  idInfo = summary_id
)


jsonlite::write_json(bettr_list, path = paste0(out_path, "/", out_name), pretty = TRUE, na = "string")


# DO NOT REMOVE
##########################################################################################
############### Define specific inputs for renku workflow tracking #######################
##########################################################################################

input_files <- c(names(file_list), unlist(info_list))
print(input_files)
#write(input_files, file=".renku/tmp/inputs.txt", append=TRUE)

sessionInfo()
