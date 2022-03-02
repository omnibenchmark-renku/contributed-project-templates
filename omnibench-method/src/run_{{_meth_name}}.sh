#!/usr/bin/env bash
# Author: Almut Lütge

#set -eo pipefail

### ------------------------------------------- ###
##  --------- Run MNN in omni_batch -----------  ##
### ------------------------------------------- ###

source src/utils/import.sh
source src/config.sh


### -------------------------------------------- ###
## --------------- Define dataset --------------- ##
### -------------------------------------------- ###

dataset_name=${DATA_VARS['name']}
renku save
create_dataset 


### -------------------------------------------- ###
## ---- Serialise project's knowledge graph ----- ##
### -------------------------------------------- ###

get_project_graph


### -------------------------------------------- ###
## --------- Update / import datasets ----------- ##
### -------------------------------------------- ###

import_datasets_by_keyword -f $OMNI_TYPE
import_datasets_by_keyword -f $OMNI_PARAM 


### -------------------------------------------- ###
## ---------- Define parameter space ------------ ##
### -------------------------------------------- ###

param_all=$(find_all_param_json $OMNI_PARAM)

param_com=$(get_method_param_combs $param_all PARAM_AR)

### -------------------------------------------- ###
## ------------ Create workflows ---------------- ##
### -------------------------------------------- ###


declare -a data_files
data_files=($(find_files_to_process .renku/provenance.json ${IN_PREFIX['count_file']}))

for data_fi in ${data_files[@]}
do
    bash src/workflow/define_workflow.sh $data_fi 
done
check_methods $OMNI_TYPE ${DATA_VARS['name']} ${METH}

### -------------------------------------------- ###
## ----------- Update workflow outputs ---------- ##
### -------------------------------------------- ###

renku update --with-siblings data/${dataset_name}/*
renku save

data_files="data/${dataset_name}/*"
meta_files=${IN_FILE['meta_file']}

add_files_to_dataset_by_name ${dataset_name} ${meta_files[@]}
add_files_to_dataset_by_name ${dataset_name} ${data_files[@]}
renku save

exit 0
