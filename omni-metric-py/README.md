# {{ name }} 
{% if project_description %}
{{ project_description }}
{% endif %}

## Metric template

This template will help you to add a metric to an omnibenchmark project. For each metric that you have, **one dedicated repository** has to be created from this template to upload the metric on the renku system. 

The configuration of a metric module is explained in details in the [Omnibenchmark documentation](https://omnibenchmark.readthedocs.io/en/latest/start/modules/03_metric_module.html)

**To configure** the project, please modify: 

- `src/{{__sanitized_project_name__}}.py` (if working with python) or 
`src/{{__sanitized_project_name__}}.R` (if working with R) with a metric to evaluate methods of an omnibenchmark

- `src/config.yaml`, to configure the project and the dataset.

- `requirements.txt` or `install.R` if you need packages or modules installed. 

- (optional) `src/generate_metric_info.py`, if you would like to change the default appearance/ transformation of the metric in the `bettr` shiny app. 

**To run the project**, please run

`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by [submitting it](https://omnibenchmark.readthedocs.io/en/latest/start/modules/04_Add_module_to_omnibench.html) to our Orchestrator Gitlab CI/CD.