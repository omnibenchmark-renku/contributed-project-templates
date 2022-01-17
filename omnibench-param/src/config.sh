#!/usr/bin/env bash

########################################
######## Project configuration #########
########################################


###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####

declare -A DATA_VARS
# Define the name of these parameters, no space or special characters. 
{% if param_name %}
DATA_VARS['name']="{{ param_name }}"
{% endif %}
# A description of this parameters. 
DATA_VARS['description']="P"
# A title
DATA_VARS['title']=""
# The tag that will be used by the methods to import the parameters. 
# Typically, the name of the benchmark followed by "_param". 
TAG_LIST=("")

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

