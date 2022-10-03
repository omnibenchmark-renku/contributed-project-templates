# {{ name }}
{% if project_description %}
{{ project_description }}
{% endif %} 

## Processing template

This template will help you to process datasets from an omnibenchmark project. Only **one processing repository** should be needed per omnibenchmark. 

The configuration of a processing module is similar to the one of a method module, which has its dedicated instructions in the [Omnibenchmark documentation](https://omnibenchmark.readthedocs.io/en/latest/start/modules/02_method_module.html#).

**To configure** the project, please modify: 

- `src/{{__sanitized_project_name__}}.py` (if working with python) or 
`src/{{__sanitized_project_name__}}.R` (if working with R) with your code to process a dataset

- `src/config.yaml`, to configure the project and the dataset.

- `requirements.txt` or `install.R` if you need packages or modules isntalled. 

**To run the project**, please run

`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by [submitting it](https://omnibenchmark.readthedocs.io/en/latest/start/modules/04_Add_module_to_omnibench.html) to our Orchestrator Gitlab CI/CD.