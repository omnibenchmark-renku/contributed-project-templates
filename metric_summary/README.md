# {{ name }}
{% if description %}
{{ description }}
{% endif %} 

## Metrics summary template

**Intended for omnibenchmark developpers only!**

This template will help you to parse metrics from an omnibenchmark project for the bettr shiny app. Only **one metrics summary repository** is needed per omnibenchmark. 

**To configure** the project, please modify: 

- `src/config.yaml`, to configure the project and the parsing.

**To run the project**, please run

`python ~/src/generate_summary.py`

Once the summary project is ready and working, you can contact the development team to integrate it in a new bettr app. 