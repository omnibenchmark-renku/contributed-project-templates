# Contributed Renku project templates for Omnibenchmark

This repository holds a collection of renkulab project templates developed for Omnibenchmark users who would like to contribute to an Omnibenchmark. 

##  `main` branch: templates for users of Renkulab.io

Create a [new project on Renkulab](https://renkulab.io/projects/new) and select `custom` template source. You can use these templates by using the repo link as URL (https://github.com/omnibenchmark/contributed-project-templates) and `main` as reference. 

## `dev` branch: templates for developers

Specific templates for developers are available on the `dev` branch of this repo. 

This branch is also used by [`omnibus`](https://github.com/omnibenchmark/omnibus) when creating/ extending omnibenchmarks via CLI. 

## `CLI_main` branch: templates for [`omnibus`](https://github.com/omnibenchmark/omnibus)

These templates are sync with the `main` branch and are meant to be used with `omnibus`. The differences with `main` are: 
- absence of `enum` in `manifest.yaml` (not accepted by CLI)
- rearangement of some Jinja variables normally created by Renkulab.io (e.g., `__sanitized_project_name__`). 

## `CLI_renkuv2_R3_5` branch: templates for older R versions

Same as `CLI_main` but meant for older R versions (modifications to Dockerfile and R installation files). 