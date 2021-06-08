#!/usr/bin/env bash
# Author: Oksana Riba Grognuz, Almut Luetge, Anthony Sonrel

#####################
## DO NOT MODIFIY ###
#####################

source src/utils/import.sh
source src/config.sh

#------------------------------------------#
#--------------- Define dataset -----------#
#------------------------------------------#

dataset_name=${DATA_VARS['name']}
create_dataset 


#-------------------------------------------#
#--- Serialise project's knowledge graph ---#
#-------------------------------------------#

renku graph generate -f
renku save

#-------------------------------------------#
#-------- Update / import datasets ---------#
#-------------------------------------------#

import_datasets_by_string $OMNI_DATA_RAW

#-------------------------------------------#
# Create workflows for unprocessed datasets #
#-------------------------------------------#

declare -a datasets
datasets=(`find_datasets_to_process`)

for dataset in ${datasets[@]}
do
    bash src/workflow/define_workflow.sh $dataset
done

#-------------------------------------------#
#---------- Update workflow outputs --------#
#-------------------------------------------#

renku update --with-siblings ${OUT_PATH}/*
renku save

data_files="${OUT_PATH}/*"
meta_files=${IN_FILE['meta_file']}

add_files_to_dataset_by_name ${dataset_name} ${meta_files[@]}
add_files_to_dataset_by_name ${dataset_name} ${data_files[@]}
renku save

exit 0
