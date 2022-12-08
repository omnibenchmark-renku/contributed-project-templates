# {{ name }} 
{% if description %}
{{ description }}
{% endif %}

## Method template

This template will help you to add a method to an omnibenchmark project. Only **one parameter repository** is needed for each omnibenchmark. 

The configuration of a parameter module simply requires to update the `src/generate_parameter_file.py` with the required parameters for one/ multiple methods of the same omnibenchmark. No further scripts or modifications of the `config.yaml` are required (if it was filled in during the project creation). 

**To configure** the project, please modify: 

- `src/generate_parameter_file.py` in the indicated section to add your parameters and the values to be used. 

- `src/config.yaml`, to configure the project and the dataset.

- `requirements.txt` or `install.R` if you need packages or modules installed. 

**To run the project**, please run

`python ~/src/run_workflow.py`

Once your module is completed and tested, you can integrate it in your Omnibenchmark by submitting it (open an issue) on the corresponding orchestrator page of your benchmark ([link to the existing orchestrators](https://omnibenchmark.pages.uzh.ch/omb-site/p/benchmarks/)). 