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

subprocess.call(['python', 'src/generate_json_from_res_files.py', '--output_name' , res_json, '--endpoint', endpoint,  '--input', *res_files])

### Run metric summary script 
summary_script = "src/benchmark_summary.R"
isExist = os.path.exists('log')
if not isExist:
    os.makedirs('log')
isExist = os.path.exists('data/'+omni_obj.name)
if not isExist:
    os.makedirs('data/'+omni_obj.name)

args = "--args"+" info_files='" +res_json+"_info.json'"+  " out_path='" + "data/"+omni_obj.name+ "' out_name='" + omni_obj.name+".json'"+ " res_files='" + res_json+".json'"
os.system('R' + ' CMD' + ' BATCH'+ ' --no-restore'+ ' --no-save "'+ args + '" ' + summary_script + ' log/summarize_metrics.Rout')  

summary_file = "data/"+omni_obj.name + "/" + omni_obj.name+".json"
update_dataset_files(urls=summary_file, dataset_name=omni_obj.name)
renku_save()

## Update dataset
renku_dataset_update(names=[omni_obj.name])
renku_save()
