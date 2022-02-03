#!/usr/bin/env bash

set -eo pipefail

# author: Almut Luetge

source src/utils/import.sh
source src/config.sh

#---------------------------------------#
#---------- Input arguments ------------#
#---------------------------------------#

count_file=$1
data_name=$(basename -- "$count_file" | sed "s/${IN_PREFIX['count_file']}_//" | sed "s/.${IN_EXT['count_file']}//")
method_script=${IN_FILE['method_script']}

#---------------------------------------#
#-– Define workflow command arguments --#
#---------------------------------------#

declare -A R_args

# argument name - value
R_args['dataset_name']=$data_name
R_args['count_file']="$count_file"
R_args['meta_file']=$(printf '%s\n' $(get_input_file_path $OMNI_TYPE meta_file) | grep "${data_name}")
R_args['out_path']="data/${DATA_VARS['name']}"


# define workflow inputs
inputs_parsed=$(echo --input $method_script $(parse_r_inputs R_args))

# define workflow parameter
#params_parsed=$(parse_parameter)

# parse arguments for R CMD
# parse_default_params_to_Rargs
R_args_parsed=$(parse_r_arguments R_args)

#---------------------------------------#
#-------- Create output folders --------#
#---------------------------------------#

mkdir -p ${R_args['out_path']}
mkdir -p log


#---------------------------------------#      
#---- Create workflow for a dataset ----#
#---------------------------------------#

command=(R CMD BATCH --no-restore --no-save "$R_args_parsed" 
         ${method_script} log/run_${METH}_${data_name}.Rout)

renku run --name $data_name $inputs_parsed -- "${command[@]}" 


exit 0