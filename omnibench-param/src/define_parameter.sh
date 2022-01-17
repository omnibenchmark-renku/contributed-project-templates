#!/usr/bin/env bash

#####################
## DO NOT MODIFIY ###
#####################

set -eo pipefail

#####################################################
############### Parameter omni batch ################
#####################################################

source src/utils/import.sh
source src/config.sh


### -------------------------------------------- ###
## ------------------- Dataset ------------------ ##
### -------------------------------------------- ###

dataset_name=${DATA_VARS['name']}
renku status
create_dataset 

mkdir -p data/${dataset_name}
out_file="${OUT_PATH}/${OUT_NAME}"

### -------------------------------------------- ###
## ---------- Create parameter JSON ------------- ##
### -------------------------------------------- ###

if [[ ! -f $out_file ]]
then
    # Write json file
    renku run --input src/generate_param_json.sh --input src/config.sh -- bash src/generate_param_json.sh
fi


### -------------------------------------------- ###
## ----------- Update workflow outputs ---------- ##
### -------------------------------------------- ###

renku update --with-siblings $out_file
renku save


### -------------------------------------------- ###
## ---------- Add output to dataset ------------- ##
### -------------------------------------------- ###


add_files_to_dataset_by_name $dataset_name $out_file
renku save

exit 0
