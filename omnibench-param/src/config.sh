#!/usr/bin/env bash

########################################
######## Project configuration #########
########################################


###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####

declare -A DATA_VARS
# Define the name of these parameters, no space or special characters. 
{% if parameters_name %}
DATA_VARS['name']="{{ parameters_name }}"
{% else %}
DATA_VARS['name']=""
{% endif %}
# The tag that will be used by the methods to import the parameters. 
# Typically, the name of the benchmark followed by "_param". 
{% if omnibench_tag %}
TAG_LIST="{{ omnibench_tag }}_param"
{% else %}
TAG_LIST=""
{% endif %}


###----------------------------------###
## ----- Define Parameter space ----- ##
###---------------------------------####

# Declare here your parameters. 
# As shown, you can use integers, characters, etc.
{% if parameters_list %}
declare -A PARAM_AR=({{ parameters_list }})
{% else %}
declare -A PARAM_AR=(['param1']="1 2 3" ['param2']="a b c")
{% endif %}


#####################
## DO NOT MODIFIY ###
#####################


###----------------------------------###
## ---------- Define Output --------- ##
###---------------------------------####

OUT_PATH="data/${DATA_VARS['name']}"
OUT_NAME="${DATA_VARS['name']}.json"

