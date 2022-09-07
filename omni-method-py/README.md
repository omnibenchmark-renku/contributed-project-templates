# {{ name }}
{% if project_description %}
{{ project_description }}
{% endif %}

## Method template

This template will help you to add a method to an omnibenchmark project. For each method that you have, **one dedicated repository** has to be created from this template to upload the method on the renku system. 

The configuration of a method module is explained in details in the [Omnibenchmark documentation](https://omnibenchmark.readthedocs.io/en/latest/start/modules/02_method_module.html)

Once your module is completed and tested, you can integrate it in your Omnibenchmark by [submitting it](https://omnibenchmark.readthedocs.io/en/latest/start/modules/04_Add_module_to_omnibench.html) to our Orchestrator Gitlab CI/CD.
