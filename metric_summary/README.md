# {{ name }}
{% if description %}
{{ description }}
{% endif %} 

## Metrics summary template

**Intended for omnibenchmark developpers only!**

This template will help you to parse metrics from an omnibenchmark project for the bettr shiny app. Only **one metrics summary repository** is needed per omnibenchmark. 

**To configure** the project, please modify: 

- `src/{{__sanitized_project_name__}}.py` (if working with python) or 
`src/{{__sanitized_project_name__}}.R` (if working with R) with your code to process a dataset

- `src/config.yaml`, to configure the project and the dataset.

- `requirements.txt` or `install.R` if you need packages or modules isntalled. 

**To run the project**, please run

`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by [submitting it](https://omnibenchmark.readthedocs.io/en/latest/start/modules/04_Add_module_to_omnibench.html) to our Orchestrator Gitlab CI/CD.