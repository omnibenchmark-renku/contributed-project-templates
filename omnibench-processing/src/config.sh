#!/usr/bin/env bash
# Author: Oksana Riba Grognuz, Almut Luetge, Anthony Sonrel


###----------------------------------###
## -------- Define Inputs ----------- ##
###---------------------------------####

## setup OMNIBENCHMARK  variables
# keyword/ string to query the raw data to process. Can be checked via: 
# https://renkulab.io/knowledge-graph/datasets?query=YOUR_QUERY
{% if omnibench_tag %}
OMNI_DATA_RAW="{{ omnibench_tag }}"
{% else %}
OMNI_DATA_RAW="" 
{% endif %}

# the tag to pass to the processed data, typically the tag that you used for raw data followed by "_processed"
# if the processed data are used in multiple benchmarks, can also be a list of tags. 
{% if omnibench_tag %}
OMNI_DATA_PROCESS="${OMNI_DATA_RAW}_processed"
{% else %}
OMNI_DATA_PROCESS="" 
{% endif %}


###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####

declare -A DATA_VARS

# name to be attributed to the processed data
{% if project_name %}
DATA_VARS['name']="{{ project_name }}"
{% else %}
DATA_VARS['name']="" 
{% endif %}

###----------------------------------###
## --------- General variables ------ ##
## ----------- DO NOT MODIFY ---------##
###---------------------------------####

declare -A IN_PREFIX
IN_PREFIX['count_file']="counts"
IN_PREFIX['meta_file']="meta"
IN_PREFIX['feature_file']="feature"
IN_PREFIX['data_generation_script']="process_data"

declare -A IN_EXT
IN_EXT['count_file']="mtx.gz"
IN_EXT['meta_file']="json"
IN_EXT['feature_file']="json"
IN_EXT['data_generation_script']="R"

declare -A IN_PATH
IN_PATH['count_file']="data/*/"
IN_PATH['meta_file']="data/*/"
IN_PATH['feature_file']="data/*/"
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
