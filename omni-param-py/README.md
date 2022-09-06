# {{ name }}
{% if description %}
{{ description }}
{% endif %}

## Method template

This template will help you to add a method to an omnibenchmark project. Only **one parameter repository** is needed for each omnibenchmark. 

The configuration of a parameter module simply requires to update the `src/generate_parameter_file.py` with the required parameters for one/ multiple methods of the same omnibenchmark. No further scripts or modifications of the `config.yaml` are required (if it was filled in during the project creation). 

Once your module is completed and tested, you can integrate it in your Omnibenchmark by [submitting it](https://omnibenchmark.readthedocs.io/en/latest/start/modules/04_Add_module_to_omnibench.html) to our Orchestrator Gitlab CI/CD.