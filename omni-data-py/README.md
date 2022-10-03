# {{ name }}
{% if project_description %}
{{ project_description }}
{% endif %}

## Dataset template

This template will help you to add a dataset to an omnibenchmark project. For each dataset that you have, **one dedicated repository** has to be created from this template to upload the data on the renku system. 

**For an example** of how the config file and the script can look like, see: 

- `src/example_config.yaml` 

- `src/example.R` 

**To configure** the project, please modify: 

- `src/{{__sanitized_project_name__}}.py` (if working with python) or 
`src/{{__sanitized_project_name__}}.R` (if working with R) with your code to add a dataset

- `src/config.yaml`, to configure the project and the dataset.

- `requirements.txt` or `install.R` if you need packages or modules isntalled. 

The configuration of a data module is explained in details in the [Omnibenchmark documentation](https://omnibenchmark.readthedocs.io/en/latest/start/modules/01_data_module.html)

**To run the project**, please run

`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by [submitting it](https://omnibenchmark.readthedocs.io/en/latest/start/modules/04_Add_module_to_omnibench.html) to our Orchestrator Gitlab CI/CD.