# {{ name }}
{% if description %}
{{ description }}
{% endif %}

## Parameters definition template

Template to define the parameters used by the methods projects. The template assumes that you uploaded datasets to Renku using the [`omnibench_dataset`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-param) template or a similar project. 

This template explains how to define the parameter space that will be used on **all** methods projects of the benchmark. 

## Steps to process your omnibenchmark data

### 1. Initialize your new project

**Ignore this step if you have already imported this template on Renku.**

I. Log in to [Renku](https://renkulab.io)

II. Create a new omnibenchmark parameter project using [this link](https://renkulab.io/projects/new?data=eyJ1cmwiOiJodHRwczovL2dpdGh1Yi5jb20vYW5zb25yZWwvY29udHJpYnV0ZWQtcHJvamVjdC10ZW1wbGF0ZXMiLCJyZWYiOiJtYWluIiwidGVtcGxhdGUiOiJDdXN0b20vb21uaWJlbmNoLXBhcmFtIn0%3D).

III. Fill in the empty fields. ome description of your project that will be passed at the begining of this readme and the metadata of your parameters. You can change them latter on in the `src/config.sh` file. 

III. Start a new environment in the `Environments` tab of your Renku project.

### 2. Process the data

I. If not done previously, fill in the metadata fields in the `src/config.sh` (you can ignore this if you provided all the information during the project creation).

II. In the `src/config.sh` file, provide your parameters 

II. Run `bash src/define_parameter.sh`. Once finished, this will add a `JSON` file in your `data` folder with all parameters that will be used by the methods. 

### 3. Next: add methods 

COMING SOON. 



