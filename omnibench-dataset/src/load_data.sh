
#!/usr/bin/env bash

#####################################################
###############  loading dataset     ################
#####################################################
source src/utils/dataset_utils

### -------------------------------------------- ###
## ----- Define tags and dataset attributes ----- ##
### -------------------------------------------- ###

dataset_name="dummy"
description="A short description of the dataset."
title="Short title."
tag_list=("dummy")


### -------------------------------------------- ###
## ------------- Create renku dataset ----------- ##
### -------------------------------------------- ###

create_dataset -n ${dataset_name} -t ${title} -d ${description} -k ${tag_list}

mkdir -p data/${dataset_name}
mkdir -p log
out_path="data/${dataset_name}"

### -------------------------------------------- ###
## ---------- Data generation workflow ---------- ##
### -------------------------------------------- ###

#inputs
data_script="src/${dataset_name}.R"

#command
renku_command=(R CMD BATCH --no-restore --no-save \
               "--args out_path=\"${out_path}\" dataset_name=\"${dataset_name}\"" \
               "${data_script}" \
               "log/generate_${dataset_name}.Rout")


#run renku
renku run --name ${dataset_name} --input ${data_script} "${renku_command[@]}" 


### -------------------------------------------- ###
## ------------ Add files to dataset ------------ ##
### -------------------------------------------- ###

blob_url="https://renkulab.io/gitlab/$OMNI_DATA_PATH/$CI_PROJECT/~/blob/master"
data_files=("${blob_url}/data/${dataset_name}/counts_${dataset_name}.mtx.gz"
            "${blob_url}/data/${dataset_name}/feature_${dataset_name}.json"
            "${blob_url}/data/${dataset_name}/meta_${dataset_name}.json" 
            "${blob_url}/data/${dataset_name}/data_info_${dataset_name}.json" )

for one_file in ${data_files[@]}
do 
renku dataset add ${dataset_name} -e ${one_file} 
done



