#!/usr/bin/env bash
# Authors: Oksana Riba Grognuz, Almut Luetge, Anthony Sonrel

########################################
######## Project configuration #########
########################################

###----------------------------------###
## -------- Define inputs ----------- ##
###---------------------------------####

# Pass here the name of your dataset 
# !! It should also correspond to your data script name !!
# don't use space or special characters
declare -A IN_PREFIX
{% if project_name %}
IN_PREFIX['data_generation_script']="{{ project_name }}"
{% else %}
IN_PREFIX['data_generation_script']="" 
{% endif %}

# Define the type of script you are using to dl/transform the data, e.g "R", "py",...
declare -A IN_EXT
{% if script_language %}
IN_EXT['data_generation_script']="{{ script_language }}"
{% else %}
IN_EXT['data_generation_script']="" 
{% endif %}

###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####


# Give here a tag for your dataset.
# This tag can be used by a new/ existing benchmark to include this dataset. 
# Typically, each benchmark has one specific tag to link all repositories (e.g. "omni_batch").
{% if tag %}
TAG_LIST=("{{ tag }}")
{% else %}
TAG_LIST=("")
{% endif %}

#####################
## DO NOT MODIFIY ###
#####################

declare -A DATA_VARS

declare -A IN_PATH
IN_PATH['data_generation_script']="src/"

DATA_VARS['name']=${IN_PREFIX['data_generation_script']}

declare -A IN_FILE
for i in "${!IN_PREFIX[@]}"
do
    IN_FILE[$i]="${IN_PATH[$i]}${IN_PREFIX[$i]}.${IN_EXT[$i]}"
done







