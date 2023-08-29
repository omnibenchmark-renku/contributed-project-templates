
![alt text](https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/omnibenchmark.png?raw=true)

<img align="right" width="100" height="100" src="https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/processing.png?raw=true">


# {{ name }}

{% if __project_description__ %} {{ __project_description__ }} {% endif %}

## Processing template

This template will help you to process datasets from an omnibenchmark project. Only **one processing repository** should be needed per omnibenchmark. 

The configuration of a processing module is similar to the one of a method module, which has its dedicated instructions in the [Omnibenchmark documentation](https://omnibenchmark.readthedocs.io/en/latest/start/modules/02_method_module.html#).

**To configure** the project, please modify: 

- `src/{{ sanitized_project_name }}.py` (if working with python) or 
`src/{{ sanitized_project_name }}.R` (if working with R) with your code to process a dataset

- `src/config.yaml`, to configure the project and the dataset.

- `requirements.txt` or `install.R` if you need packages or modules isntalled. 

You can **check the requirements** for this module by running: 

```
import omniValidator as ov
ov.display_requirements(
    benchmark = "{{sanitized_project_name}}", # <-- the name of this Omnibenchmark
    keyword="{{processed_keyword}}" # <-- the keyword of this module
)
```

**To run the project**, then run

`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by submitting it (open an issue) on the corresponding orchestrator page of your benchmark ([link to the existing orchestrators](https://omnibenchmark.github.io/documentation/01_getting_started/01_module_contr/setup_module/04_submit/)). 