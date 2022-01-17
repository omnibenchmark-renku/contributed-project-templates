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

I. On the Renku page, click *new project*. 

II. In the fields, paste: 

- an *omnibenchmark* project group, or your own namespace (default) in `Namespace`,

- `https://github.com/ansonrel/contributed-project-templates` in `Repository URL`,

-  `main` in the `Repository Reference`,

-  `fetch templates`

-  `Custom - Basic omnibenchmark parameters` as a template. 

-  Some description of your project that will be passed at the begining of this readme. 

III. Start a new environment in the `Environments` tab of your Renku project.

### 2. Process the data

I. **Fill in the fields in the `src/config.sh`**. The most important fields are

- `TAG_LIST`: a tag (or list of tags) that will allow to link this project to the methods' projects. 

- `PARAM_AR`: a list of parameters that can be used by all methods' projects. These can be integers, characters, etc. If one method does not use of these parameters, it will simply ignore it. 

II. Run `bash src/define_parameter.sh`. Once finished, this will add a `JSON` file in your `data` folder with all parameters that will be used by the methods. 

### 3. Next: add methods 

COMING SOON. 



