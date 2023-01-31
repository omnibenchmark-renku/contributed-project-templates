# {{ name }}
{% if description %}
{{ description }}
{% endif %} 

## Metrics summary template

**!Intended for omnibenchmark developpers only!**

This template will help you to parse metrics from an omnibenchmark project for the bettr shiny app. Only **one metrics summary repository** is needed per omnibenchmark. 

**Before** using this template, make sure that your benchmark: 

- ran at least 1 successful pipeline with dataset(s), method(s), metric(s)

- that you have a dedicated triplestore instance for this benchmark

- that the pipeline correctly sent the triples to the triplestore (see also the configuation of an [Orchestrator](https://github.com/ansonrel/contributed-project-templates/tree/dev/orchestrator) and particularly the setup of the `OMNI_UPDATE_TOKEN`).

### Quick setup

**To configure** the project, please modify: 

- `src/config.yaml`, to configure the project and the parsing. The important fields to look at are `description`, `benchmark_name` and `keywords`. 

**To run the project**, please run

`python ~/src/generate_summary.py`

Which will create a summary of all metrics parsed for the bettr app, usually in `data/{{__sanitized_project_name__}}/{{__sanitized_project_name__}}.json`

Once the summary project is ready and working, you can contact the development team to integrate it in a new bettr app and specify the path to the output file to push to the app.

### More details

The goal of this project is to parse the many metrics of the benchmark to a JSON that can be read and displayed by a `bettr` app instance. 

This project imports all metrics of the benchmark specified by the `config.yaml`. 