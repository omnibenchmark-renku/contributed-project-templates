# {{ name }}
{% if description %}
{{ description }}
{% endif %} 

## Metrics summary template

**Intended for omnibenchmark developpers only!**

This template will help you to parse metrics from an omnibenchmark project for the bettr shiny app. Only **one metrics summary repository** is needed per omnibenchmark. 

**To configure** the project, please modify: 

- `src/config.yaml`, to configure the project and the parsing. The important fields to look at are `description`, `benchmark_name` and `keywords`. 

**To run the project**, please run

`python ~/src/generate_summary.py`

Which will create a summary of all metrics parsed for the bettr app, usually in `data/{{__sanitized_project_name__}}/{{__sanitized_project_name__}}.json`

Once the summary project is ready and working, you can contact the development team to integrate it in a new bettr app and specify the path to the output file to push to the app.

