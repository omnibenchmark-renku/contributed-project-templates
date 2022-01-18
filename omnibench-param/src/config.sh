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
# A description of this parameters. 
{% if parameters_description %}
DATA_VARS['description']="{{ parameters_description }}"
{% else %}
DATA_VARS['description']=""
{% endif %}
# A title
{% if parameters_title %}
DATA_VARS['title']="{{ parameters_title }}"
{% else %}
DATA_VARS['title']=""
{% endif %}
# The tag that will be used by the methods to import the parameters. 
# Typically, the name of the benchmark followed by "_param". 
{% if parameters_tags %}
TAG_LIST=("")=("{{ parameters_tags }}")
{% else %}
TAG_LIST=("")
{% endif %}

###----------------------------------###
## ----- Define Parameter space ----- ##
###---------------------------------####

# Declare here your parameters. 
# As shown, you can use integers, characters, etc.
declare -A PARAM_AR=(
  ['param1']="1 2 3"
  ['param2']="a b c"
)



#####################
## DO NOT MODIFIY ###
#####################


###----------------------------------###
## ---------- Define Output --------- ##
###---------------------------------####

OUT_PATH="data/${DATA_VARS['name']}"
OUT_NAME="${DATA_VARS['name']}.json"

