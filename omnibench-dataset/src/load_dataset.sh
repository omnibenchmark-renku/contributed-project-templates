#!/usr/bin/env bash

#####################################################
################### Omni dataset  ###################
#####################################################

#####################
## DO NOT MODIFIY ###
#####################

source src/utils/import.sh
source src/config.sh

### -------------------------------------------- ###
## --------------- Define dataset --------------- ##
### -------------------------------------------- ###

dataset_name=${DATA_VARS['name']}
renkus status
create_dataset 


### -------------------------------------------- ###
## ---- Serialise project's knowledge graph ----- ##
### -------------------------------------------- ###

get_project_graph

### -------------------------------------------- ###
## ---------- Data generation workflow ---------- ##
### -------------------------------------------- ###

workflow_exists=(`list_plan_inputs .renku/provenance.json ${IN_FILE['data_generation_script']}`)

if [ -z "$workflow_exists" ]
then
    bash src/workflow/define_workflow.sh $dataset_name
fi

### -------------------------------------------- ###
## ----------- Update workflow outputs ---------- ##
### -------------------------------------------- ###

renku update --with-siblings data/${dataset_name}/*
renku save


### -------------------------------------------- ###
## ------------ Add files to dataset ------------ ##
### -------------------------------------------- ###

data_files="data/${dataset_name}/*"
add_files_to_dataset_by_name ${dataset_name} ${data_files[@]}
renku save


