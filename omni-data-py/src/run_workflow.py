from omnibenchmark.utils.build_omni_object import get_omni_object_from_yaml
from omnibenchmark.renku_commands.general import renku_save


## Load config
omni_obj = get_omni_object_from_yaml('src/config.yaml')

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

## Run workflow
omni_obj.run_renku()
renku_save()

## Update Output dataset
omni_obj.update_result_dataset()
renku_save()
