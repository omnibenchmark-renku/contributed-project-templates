#!/usr/bin/env bash
# Author: Oksana Riba Grognuz, Almut Luetge, Anthony Sonrel

#####################
## DO NOT MODIFIY ###
#####################

source src/utils/import.sh
source src/config.sh

#---------------------------------------#
#------- Read input arguments ----------#
#---------------------------------------#

dataset_name=$1
process_script=${IN_FILE['data_generation_script']}

#---------------------------------------#
#-– Define workflow command arguments --#
#---------------------------------------#

declare -A R_args

# argument name - value
R_args['dataset_name']=$dataset_name
R_args['count_file']=`get_input_file_path $dataset_name count_file`
R_args['meta_file']=`get_input_file_path $dataset_name meta_file`
R_args['out_path']=${OUT_PATH}

# parse arguments for R CMD
R_args_parsed=`parse_r_arguments R_args`

# parse input files for renku command
inputs_parsed=$(echo --input $process_script `parse_r_inputs R_args`)

#---------------------------------------#
#-------- Create output folders --------#
#---------------------------------------#

mkdir -p ${R_args['out_path']}
mkdir -p log

#---------------------------------------#      
#---- Create workflow for a dataset ----#
#---------------------------------------#

command=(R CMD BATCH --no-restore --no-save "$R_args_parsed" 
         src/process_data.R log/process_${dataset_name}.Rout)

renku run --name $dataset_name $inputs_parsed -- "${command[@]}" 


exit 0
