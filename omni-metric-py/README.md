# {{ name }}
{% if description %}
{{ description }}
{% endif %}

## Metric template

This template will help you to add a metric to an omnibenchmark project. For each metric that you have, **one dedicated repository** has to be created from this template to upload the metric on the renku system. 

The configuration of a metric module is explained in details in the [Omnibenchmark documentation](https://omnibenchmark.readthedocs.io/en/latest/start/modules/03_metric_module.html)

Once your module is completed and tested, you can integrate it in your Omnibenchmark by [submitting it](https://omnibenchmark.readthedocs.io/en/latest/start/modules/04_Add_module_to_omnibench.html) to our Orchestrator Gitlab CI/CD.