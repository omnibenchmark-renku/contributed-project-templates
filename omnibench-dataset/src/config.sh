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
declare -A IN_PREFIX
IN_PREFIX['data_generation_script']="" 

# Define the type of script you are using to dl/transform the data, e.g "R", "py",...
declare -A IN_EXT
IN_EXT['data_generation_script']="R" 

declare -A IN_PATH
IN_PATH['data_generation_script']="src/"

###----------------------------------###
## ---- Define Dataset variables ---- ##
###---------------------------------####

declare -A DATA_VARS
DATA_VARS['name']=""
DATA_VARS['description']=""
DATA_VARS['title']=""

TAG_LIST=("")




#####################
## DO NOT MODIFIY ###
#####################


declare -A IN_FILE
for i in "${!IN_PREFIX[@]}"
do
    IN_FILE[$i]="${IN_PATH[$i]}${IN_PREFIX[$i]}.${IN_EXT[$i]}"
done







