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
IN_EXT['script_language']="{{ script_language }}"
{% else %}
IN_EXT['script_language']="" 
{% endif %}

###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####

declare -A DATA_VARS

# Describe here your dataset, for example tissue of origin, type of dataset, etc.
{% if metadata_description %}
DATA_VARS['description']="{{ metadata_description }}"
{% else %}
DATA_VARS['description']=""
{% endif %}

# Give here a title for your dataset.
{% if name %}
DATA_VARS['title']="{{ name }}"
{% else %}
DATA_VARS['title']=""
{% endif %}

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


declare -A IN_PATH
IN_PATH['data_generation_script']="src/"

DATA_VARS['name']=${IN_PREFIX['data_generation_script']}

declare -A IN_FILE
for i in "${!IN_PREFIX[@]}"
do
    IN_FILE[$i]="${IN_PATH[$i]}${IN_PREFIX[$i]}.${IN_EXT[$i]}"
done







