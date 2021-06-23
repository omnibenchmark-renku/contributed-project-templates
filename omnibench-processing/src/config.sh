#!/usr/bin/env bash
# Author: Oksana Riba Grognuz, Almut Luetge, Anthony Sonrel


###----------------------------------###
## -------- Define Inputs ----------- ##
###---------------------------------####

## setup OMNIBENCHMARK  variables
# keyword/ string to query the raw data to process. Can be checked via: 
# https://renkulab.io/knowledge-graph/datasets?query=YOUR_QUERY
OMNI_DATA_RAW=""
# the tag to pass to the processed data
TAG_LIST=""


###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####

declare -A DATA_VARS

# name to be attributed to the processed data
DATA_VARS['name']="" 
# description of the processing step that will be performed
DATA_VARS['description']="" 
# human readable title for the processed data
DATA_VARS['title']="" 


###----------------------------------###
## --------- General variables ------ ##
## ----------- DO NOT MODIFY ---------##
###---------------------------------####

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
## --------- General variables ------ ##
###---------------------------------####

OUT_PATH="data/${DATA_VARS['name']}"
