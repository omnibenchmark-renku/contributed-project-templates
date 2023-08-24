![alt text](https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/omnibenchmark.png?raw=true)

<img align="right" width="100" height="100" src="https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/dataset.png?raw=true">

# {{ name }}
{% if description %}
{{ description }}
{% endif %} 

## Metrics summary template

**!Intended for omnibenchmark developers only!**

This template will help you to parse metrics from an omnibenchmark project for the bettr shiny app. Only **one metrics summary repository** is needed per omnibenchmark. 

**Before** using this template, make sure that your benchmark: 

- ran at least 1 successful pipeline with dataset(s), method(s), metric(s)

- that you have a dedicated triplestore instance for this benchmark

- that the pipeline correctly sent the triples to the triplestore (see also the configuration of an [Orchestrator](https://github.com/omnibenchmark/contributed-project-templates/tree/dev/orchestrator) and particularly the setup of the `OMNI_UPDATE_TOKEN`).

### Quick setup

**To configure** the project, please modify: 

- `src/config.yaml`, to configure the data to import. The important fields to look at are `description` (triplestore URL), `benchmark_name`, `input:keywords` and `files`/`prefix` (if now already set during project creation). 

- `src/config.yaml`, to configure the workflow to parse the metrics. The important fields to look at are `benchmark_name` and `keywords` (if now already set during project creation).

**To run the project**, please run

`python ~/src/run_workflow.py`

Which will create a summary of all metrics parsed for the `bettr` app, usually in `data/{{ sanitized_project_name }}`

Once the summary project is ready and working, you can contact the development team to integrate it in a new `bettr` app and specify the path to the output file to push to the app.



### More details

The goal of this project is to parse the many metrics of the benchmark to a JSON that can be read and displayed by a `bettr` app instance. 

This project imports all metrics of the benchmark specified by the `config.yaml` and retrieves their lineage information using the [omnisparql](https://github.com/omnibenchmark/omniSparql) package. The lineage information is retrieved with SPARQL queries on the Jena triplestore that received triples from all running projects. For example, the queries will be able to identify which method file was used to produce each single metric file. The `geneate_json_from_res_files.py` is a collection of SPARQL queries to retrieve such lineage information from the metric files. 

The configuration of the **input data** for the project is done through the `config.yaml` file. The most important fields are: 

- `description`: should point to the triplestore URL that received the triples. Contact the admins of the triplestore to get the URL of your omnibenchmark. 

- `benchmark_name`: Name of the omnibenchmark

- `inputs:keywords`: keyword specified in the metric modules

- `files`: file types (with associated `prefix`) that should be imported. Usually 1 type corresponding to the output metric files (1 per metric/ method/ parameter/ dataset combination) and 1 for metric information files (1 per metric). The prefixes can usually be easily determined by looking at the pattern of imported file names or by examination of metric's `config.yaml`. 

The configuration of the **workflow** parsing the metrics to a `bettr` format is done through the `config_summary.yaml` file. The most important fields are: 

- `description`: should point to the triplestore URL that received the triples. Contact the admins of the triplestore to get the URL of your omnibenchmark. 

- `benchmark_name`: Name of the omnibenchmark

- `keywords`: keyword specified in the metric modules

The **naming scheme** of the benchmark components can be modified (for the bettr app visualization) via the `data/bettr_transform.tsv` file, where: 

- `type`: defines the benchmark step. One of "dataset", "preprocessing", "method" or "parameter"

- `original_name`: defined the name of the component 

- `bettr_name`: new name of the component that will be shown on the bettr app

- `class`: for parameters, re-assign the class. One of "as.numeric", "as.character" or "as.factor". 




Finally, the project can be run with: 

`python ~/src/run_workflow.py`

The first part of the section consists of usual `omnibenchmark` calls to import upstream datasets. The second part will call the `generate_json_from_res_files.py` that contains wrappers around the `omniSparql` module to retrieve lineage information and aggregate all information in `data/metric_result_file_sparql.json`. The last step will parse the aggregated data to a `bettr` format. 

Once the script has been successfully run, you can contact the development team to configure a new `bettr` shiny app instance. Please specify in your message the name of the benchmark and the path to the final output file, usually in `{{__sanitized_project_name__}}/{{__sanitized_project_name__}}.json`. 

