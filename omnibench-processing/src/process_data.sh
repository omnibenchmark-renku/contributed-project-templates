#!/usr/bin/env bash

#####################
## DO NOT MODIFIY ###
#####################

source src/utils/import.sh
source src/config.sh

#------------------------------------------#
#--------------- Define dataset -----------#
#------------------------------------------#

dataset_name=${DATA_VARS['name']}
renku save
renku status
create_dataset 


#-------------------------------------------#
#--- Serialise project's knowledge graph ---#
#-------------------------------------------#

get_project_graph

#-------------------------------------------#
#-------- Update / import datasets ---------#
#-------------------------------------------#

import_datasets_by_keyword -f $OMNI_DATA_RAW

#-------------------------------------------#
# Create workflows for unprocessed datasets #
#-------------------------------------------#

declare -a datasets
datasets=(`find_datasets_to_process`)

renku save
for dataset in ${datasets[@]}
do
    bash src/workflow/define_workflow.sh $dataset
    {% if omnibench_tag=="omni_batch" %}
    schema_check_processed $dataset "${OMNI_DATA_PROCESS[@]}"
    {% endif %}
done

#-------------------------------------------#
#---------- Update workflow outputs --------#
#-------------------------------------------#

renku update ${OUT_PATH}/*
renku save

data_files="${OUT_PATH}/*"
meta_files=${IN_FILE['meta_file']}

add_files_to_dataset_by_name ${dataset_name} ${meta_files[@]}
add_files_to_dataset_by_name ${dataset_name} ${data_files[@]}
renku save

exit 0
