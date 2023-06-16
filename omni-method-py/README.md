![alt text](https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/omnibenchmark.png?raw=true)

<img align="right" width="100" height="100" src="https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/method.png?raw=true">


# {{ name }}

{% if __project_description__ %} {{ __project_description__ }} {% endif %}

## Method template 

This template will help you to add a method to an omnibenchmark project. For each method that you have, **one dedicated repository** has to be created from this template to upload the method on the renku system. 

The configuration of a method module is explained in details in the [Omnibenchmark documentation](https://omnibenchmark.readthedocs.io/en/latest/start/modules/02_method_module.html)

**To configure** the project, please modify: 

- `src/{{ sanitized_project_name }}.py` (if working with python) or 
`src/{{ sanitized_project_name }}.R` (if working with R) with your wrapper of a method to benchmark

- `src/config.yaml`, to configure the project and the dataset.

- `requirements.txt` or `install.R` if you need packages or modules installed. 

You can **check the requirements** for this module by running: 

```
import omniValidator as ov
ov.display_requirements(
    benchmark = "{{benchmark_name}}", # <-- the name of this Omnibenchmark
    keyword="{{method_keyword}}" # <-- the keyword of this module
)
```

**To run the project**, then run


`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by submitting it (open an issue) on the corresponding orchestrator page of your benchmark ([link to the existing orchestrators](https://omnibenchmark.pages.uzh.ch/omb-site/p/benchmarks/)). 