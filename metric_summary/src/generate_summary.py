from omnibenchmark.utils.build_omni_object import get_omni_object_from_yaml
from omnibenchmark.renku_commands.general import renku_save
from omnibenchmark.management.data_commands import update_dataset_files
from omnibenchmark.renku_commands.datasets import renku_dataset_update
import subprocess
import os as os
renku_save()

## Load config
omni_obj = get_omni_object_from_yaml('src/config.yaml')

# endpoint from description
endpoint = omni_obj.description

## Update object
omni_obj.update_object()
renku_save()

## Check object
print(
    f"Object attributes: \n {omni_obj.__dict__}\n"
)

## Create output dataset
omni_obj.create_dataset()
renku_save()

### Sparql script to get file infos
res_files = [x["metric_res"] for x in list(omni_obj.inputs.input_files.values())]
res_json =  "data/metric_result_file_sparql"
res_files[0:5]

## For DEVs: do NOT try to put this in a renku workflow. 
## The list of files may vary which would break renku workflows. 
subprocess.call(['python', 'src/generate_json_from_res_files.py', '--output_name' , res_json, '--endpoint', endpoint,  '--input', *res_files])

### Run metric summary script  --------------------------
renku_save()

## Load config
omni_obj = get_omni_object_from_yaml('src/config_summary.yaml')

## Update object
omni_obj.update_object()
renku_save()

## Check object
print(
    f"Object attributes: \n {omni_obj.__dict__}\n"
)
print(
    f"File mapping: \n {omni_obj.outputs.file_mapping}\n"
)
print(
    f"Command line: \n {omni_obj.command.command_line}\n"
)

## Create output dataset
omni_obj.create_dataset()
renku_save()

## Run workflow
omni_obj.run_renku()
renku_save()

## Update Output dataset
omni_obj.update_result_dataset()
renku_save()
