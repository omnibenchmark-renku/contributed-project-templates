from omnibenchmark.utils.build_omni_object import get_omni_object_from_yaml
from omnibenchmark.renku_commands.general import renku_save
renku_save()

## Load config
omni_obj = get_omni_object_from_yaml('src/config.yaml')

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

## Run workflow
omni_obj.run_renku()
renku_save()

## Update Output dataset
omni_obj.update_result_dataset()
renku_save()

###################### Generate info file ######################

omni_info = get_omni_object_from_yaml('src/info_config.yaml')
omni_info.wflow_name = "{{__sanitized_project_name}}_info"

## Check object
print(
    f"Object attributes: \n {omni_info.__dict__}\n"
)
print(
    f"File mapping: \n {omni_info.outputs.file_mapping}\n"
)
print(
    f"Command line: \n {omni_info.command.command_line}\n"
)

## Run workflow
omni_info.run_renku()
renku_save()

## Update Output dataset
omni_info.update_result_dataset()
renku_save()

################################################################
