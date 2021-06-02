#!/usr/bin/env bash
# Author: Oksana Riba Grognuz, Almut Luetge, Anthony Sonrel


###----------------------------------###
## -------- Define Inputs ----------- ##
###---------------------------------####

# setup OMNIBENCHMARK  variables
OMNI_DATA_RAW=""
OMNI_DATA_PROCESSED=""
OMNI_DATA_NAMESPACE=""


declare -A IN_PREFIX
IN_PREFIX['count_file']="counts"
IN_PREFIX['meta_file']="meta"
IN_PREFIX['data_generation_script']="process_data"

declare -A IN_EXT
IN_EXT['count_file']="mtx.gz"
IN_EXT['meta_file']="json"
IN_EXT['data_generation_script']="R"

declare -A IN_PATH
IN_PATH['count_file']="data/*/"
IN_PATH['meta_file']="data/*/"
IN_PATH['data_generation_script']="src/"

declare -A IN_FILE
for i in "${!IN_PREFIX[@]}"
do
    IN_FILE[$i]=`echo ${IN_PATH[$i]}${IN_PREFIX[$i]}*.${IN_EXT[$i]}`
done


###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####

declare -A DATA_VARS
DATA_VARS['name']="omni_batch_processed"
DATA_VARS['description']="Normalized counts, reduced dimensions and hvg of omni_batch datasets."
DATA_VARS['title']="processed omni_batch data - omni_batch_processed"

TAG_LIST=("omni_batch_processed")

###----------------------------------###
## --------- General variables ------ ##
###---------------------------------####

OUT_PATH="data/${DATA_VARS['name']}"
