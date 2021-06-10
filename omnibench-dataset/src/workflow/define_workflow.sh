#!/usr/bin/env bash
# author: Almut Lütge

#####################
## DO NOT MODIFIY ###
#####################

source src/utils/import.sh
source src/config.sh

#---------------------------------------#
#----------- Define arguments ----------#
#---------------------------------------#

dataset_name=$1
data_script=${IN_FILE[data_generation_script]}

declare -A R_args

# argument name - value
R_args['out_path']="data/${dataset_name}"
R_args['dataset_name']="${dataset_name}"

# parse arguments for R CMD
R_args_parsed=`parse_r_arguments R_args`

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
 
# outputs
outfiles="--output data/${dataset_name}/counts_${dataset_name}.mtx.gz --output data/${dataset_name}/data_info_${dataset_name}.json --output data/${dataset_name}/feature_${dataset_name}.json --output data/${dataset_name}/meta_${dataset_name}.json"

#---------------------------------------#      
#---- Create workflow for a dataset ----#
#---------------------------------------#
renku run --name $dataset_name --input ${data_script} ${outfiles} -- "${command[@]}"


exit 0