![alt text](https://github.com/ansonrel/contributed-project-templates/blob/main/img/omnibenchmark.png?raw=true)

<img align="right" width="100" height="100" src="https://github.com/ansonrel/contributed-project-templates/blob/main/img/dataset.png?raw=true">


# {{ name }}

{% if __project_description__ %} {{ __project_description__ }} {% endif %}

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

You can **check the requirements** for this module by running: 

```
import omniValidator as ov
ov.display_requirements(
    benchmark = "{{benchmark_name}}", # <-- the name of this Omnibenchmark
    keyword="{{dataset_keyword}}" # <-- the keyword of this module
)
```

**To run the project**, then run

`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by submitting it (open an issue) on the corresponding orchestrator page of your benchmark ([link to the existing orchestrators](https://omnibenchmark.pages.uzh.ch/omb-site/p/benchmarks/)). 