#!/usr/bin/env bash


#####################
## DO NOT MODIFIY ###
#####################


source src/utils/import.sh
source src/config.sh

#---------------------------------------#
#----------- Define arguments ----------#
#---------------------------------------#

dataset_name=$1
data_script=${IN_FILE['data_generation_script']}

declare -A R_args

# argument name - value
R_args['out_path']="data/${dataset_name}"

# parse arguments for R CMD
R_args_parsed=$(parse_r_arguments R_args)

#---------------------------------------#
#-------- Create output folders --------#
#---------------------------------------#

mkdir -p ${R_args['out_path']}
mkdir -p log

#---------------------------------------#
#---------- Define R command -----------#
#---------------------------------------#
command=(R CMD BATCH --no-restore --no-save "$R_args_parsed" 
         $data_script log/generate_${dataset_name}.Rout)
            
#---------------------------------------#      
#---- Create workflow for a dataset ----#
#---------------------------------------#
renku run --name $dataset_name --input ${data_script} -- "${command[@]}"


exit 0
