#!/usr/bin/env bash

# author: Oksana Riba Grognuz & Almut Luetge

########################################################
############## Dataset Utils Functions #################
########################################################

WORK_DIR="/work/${CI_PROJECT}"

## -------------------------------------------------- ##
## ------ Functions to query datasets on the KG ------##
## -------------------------------------------------- ##

function query_datasets_by_string () {
    # string
    curl -s "https://renkulab.io/knowledge-graph/datasets?query=$1" | jq -r '.[] | .identifier'
}


function query_datasets_by_string_unique () {
    # string
    curl -s "https://renkulab.io/knowledge-graph/datasets?query=cellbench" | jq -r 'unique_by( .name ) | .[] | .identifier'
}


function match_datasets_keywords () {

    local dataset_id=$1
    local keyword=`echo $2 | awk '{print tolower($0)}'`
    local field=${3:-identifier}

   
   curl -s "https://renkulab.io/knowledge-graph/datasets/$dataset_id" \
   | jq -r 'select(.keywords[] | ascii_downcase == ('\"$keyword\"')) | .'\"$field\"''
   }
   

function query_datasets_by_keyword () {

   local keyword=$1
   local field=${2:-identifier}  
   
   for dataset_id in `query_datasets_by_string_unique "$keyword"`
   do 
       match_datasets_keywords $dataset_id "$keyword" $field
   done
   }
   

function datasets_properties_by_id () {

   local dataset_id=$1
   local field=${2:-name}  
   
   curl -s "https://renkulab.io/knowledge-graph/datasets/$dataset_id" | jq -r '.'\"$field\"''
   }
   
   
function import_datasets_by_keyword () {
   
   local keyword=$1
   
   for dataset_id in `query_datasets_by_keyword $keyword identifier`
   do
      
      local data_name=`datasets_properties_by_id $dataset_id name`
      local data_path="${WORK_DIR}/data/${data_name}"
      local data_url=`datasets_properties_by_id $dataset_id url`
      
      if [ -d "${data_path}" ]
      then
         renku dataset update $data_name
      else
         renku dataset import -y $data_url
      fi
   done
   }


function dataset_files_by_id () {

   local dataset_id=$1
   curl -s "https://renkulab.io/knowledge-graph/datasets/${dataset_id}" \
                       | jq -r ".hasPart | .[] | .atLocation"
   }


## -------------------------------------------------- ##
## ---- Functions to wrangle datasets using renku --- ##
## -------------------------------------------------- ##

function create_dataset () {
    
    create_dataset_usage() { 
       echo "create_dataset: [-n <name> -t <title> -d <description> -k <keyword(s)>]" 1>&2; exit; 
       }
    
    local create_opt=""
    local OPTIND o name
    
    while getopts ":n:t:d:k:" o; do
        case "${o}" in
            n)
                name="${OPTARG}"
                ;;
            t)
                create_opt="$create_opt -t \"${OPTARG}\""
                ;;
            d)
                create_opt="$create_opt -d \"${OPTARG}\""
                ;;
            k)
                create_opt="$create_opt -k \"${OPTARG}\""
                ;;
            *)
                create_dataset_usage
                ;;
        esac
    done
    shift $((OPTIND-1))
    
    local out_exists=`renku dataset ls | awk -v var=$name '$2==var' | wc -l`
    
    if [ $out_exists -eq 0 ]  
    then
        echo "Creating $name"
        renku dataset create ${name} $create_opt
    fi
   }


function add_files_to_dataset_by_name () {
   
    local dataset_name=$1
    local file_names=(${@:2})
   
    for file in ${file_names[@]}
    do
        local file_path="data/${dataset_name}/${file}"
        local file_exists=`renku dataset ls-files $dataset_name -I "${file_path}" | wc -l`
        
        if [ $file_exists -gt 2 ]
        then
            # update file using renku command.
            renku dataset update -I $file_path $dataset_name
        else
            echo "Adding $file_path to the dataset $dataset_name"
            renku dataset add ${dataset_name} ${file_path}
        fi
    done
   }
   

## --------------------------------------------------- ##
## -- Functions to find datasets with updated files -- ##
## --------------------------------------------------- ##

function find_new_dataset_by_key () {
   
    local keyword=$1
    local data_new=()
   
   for dataset_id in `query_datasets_by_keyword $keyword identifier`
   do
      
      local data_name=`datasets_properties_by_id $dataset_id name`
      local data_path="${WORK_DIR}/data/${data_name}"
      
      if [ ! -d "${data_path}" ]
      then
         data_new+=("$data_id")
      fi
   done
   echo ${data_new[@]}
   }
