#!/usr/bin/env bash

###########################################
######### Project configuration ###########
###########################################

###-------------------------------------###
## ------ Define general variables ----- ##
###-------------------------------------###

# Define variables describing the input dataset name (OMNI_TYPE), ..
{% if omnibench_tag %}
OMNI_TYPE="{{ omnibench_tag }}_processed"
{% else %}
OMNI_TYPE=""
{% endif %}
#the input parameters dataset name (OMNI_PARAM),..
{% if omnibench_tag %}
OMNI_PARAM="{{ omnibench_tag }}_param"
{% else %}
OMNI_PARAM=""
{% endif %}
#the methods name (METH) ,...
{% if meth_name %}
METH="{{ meth_name }}"
{% else %}
METH=""
{% endif %}
# and the tag for the method.
{% if omnibench_tag %}
TAG_LIST="{{ omnibench_tag }}_method"
{% else %}
TAG_LIST=""
{% endif %}

###-------------------------------------###
## ------ Define parameter space ------- ##
###-------------------------------------###

# Define array with all valid parameter names as keys and their corresponding defaults as values
declare -A PARAM_AR
PARAM_AR["lambda"]="1"
PARAM_AR["d"]="20"
PARAM_AR["k"]="10"


###-------------------------------------###
## --------- Define inputs ------------- ##
###-------------------------------------###
declare -A IN_EXT
declare -A IN_PREFIX
declare -A IN_PATH
declare -A DATA_VARS
declare -A IN_FILE

{% if script_suffix %}
IN_EXT['method_script']="{{ script_suffix }}"
{% else %}
IN_EXT['method_script']=""
{% endif %}



#####################
## DO NOT MODIFIY ###
#####################


###-------------------------------------###
## -- Define output dataset variables -- ##
###-------------------------------------###

# Define array that contains output dataset features (name, description and title)
DATA_VARS['name']="${METH}"

IN_PREFIX['method_script']=$METH

# Define all general neccessary method input file features (name prefix, file extension, path)
IN_PREFIX['count_file']="norm_counts"
IN_PREFIX['meta_file']="meta"
IN_PREFIX['hvg_file']="hvg"

IN_EXT['count_file']="mtx.gz"
IN_EXT['meta_file']="json"
IN_EXT['hvg_file']="json"

IN_PATH['method_script']="src/"
IN_PATH['count_file']="data/$OMNI_TYPE/"
IN_PATH['meta_file']=${IN_PATH['count_file']}
IN_PATH['hvg_file']=${IN_PATH['count_file']}


for i in "${!IN_PREFIX[@]}"
do
    IN_FILE[$i]=`echo ${IN_PATH[$i]}${IN_PREFIX[$i]}*.${IN_EXT[$i]}`
done


