![alt text](https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/omnibenchmark.png?raw=true)

<img align="right" width="100" height="100" src="https://github.com/omnibenchmark/contributed-project-templates/blob/main/img/dataset.png?raw=true">

# orchestrator-template 

General Orchestrator template. In this `README.md`, it is recommended to give a short description of the project, or at least give links to other organizational aspects of the project.

A list of existing orchestrators and their components is available on the [Omnibenchmark dashboard](https://omnibenchmark.pages.uzh.ch/omb-site/p/benchmarks/) and the list of projects in the [Projects section](https://omnibenchmark.pages.uzh.ch/omb-site/p/projects/).

Recommendation: keep a running list of the repos below that are connected, just as a record of what was done. Later, we'll see these in the knowledge graph / triplestore.

## Datasets

URL1
URL2

## Preprocessing/ filtering

URL1
URL2

## Methods

URL1
URL2

## Metrics


URL1
URL2


## Q & A 

### Can a project run without the orchestrator ? 

Yes, to some extend. The project will be able to run, import datasets and export its output to other 
modules. However a project needs to be integrated into the orchestrator of an Omnibenchmark to be able to 
be run with the rest of the Omnibenchmark and for its results to be displayed on the `bettr` shiny app. 

### I'm an **user of Omnibenchmark** and would like to submit a module to the orchestrator

Please open an issue on the orchestrator page of the Omnibenchmark that you would like to contribute to. 

### I'm an **Omnibenchmark developper** and would like to setup the orchestrator 

Before adding projects to the orchestrator, you can configure the orchestrator as follows: 

1) Ask the development team to setup a triplestore instance for: http://omnibenchmark.org/{{benchmark_name}}_data

If a triplestore instance was already set using a different name, please modify the `TRIPLESTORE_URL` of your `gitlab-ci.yml`.

2) In the `.gitlab-ci.yml` file of the orchestrator, define the steps of your benchmark under the [`stages`](https://github.com/omnibenchmark/contributed-project-templates/blob/dev/orchestrator/.gitlab-ci.yml#L35) section. This will define the different steps of your benchmark (one or multiple projects will be assigned to a step) and their order of execution. 

3) Setup the tokens that will give the access to the triggered projects.

On the renkulab page of the orchestrator, on the toolbar on the right-hand side, go to `settings` > `CI/CD` > `Variables` 
and under `Add variable`, add: 

- your personal access token in there and **name it `CI_PUSH_TOKEN`** [1]

- the token to populate the omnibencmark triplestore (contact dev team) and **name it `OMNI_UPDATE_TOKEN`**

[1] If you don't own such token, you can create one by following 
[these instructions](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) and 
select at least "api, read api" as scope. 

4) Create a pipeline schedule: 

- on the Renku Gitlab page, go to `CI/CD` > `Schedules`

- Open `New schedule` 

- Give a description and disable the `Active` box (if you want to manually trigger pipelines). 

- Your orchestrator is ready to run! You can activate your pipeline when it's ready by clicking on the `play` button. 

### I'm an **Omnibenchmark developper** and would like to add a project to the orchestrator 

**Prerequisites**: Make sure that the project was already run once and is functional. 

1) In the `.gitlab-ci.yml` file of the orchestrator, add: 

```
trigger_YOUR-NEW-PROJECT:  # <-- To modify
  stage: PROJECT-STAGE     # <-- To modify
  only:
    - schedules
  trigger: 
    project: PROJECT_PATH  # <-- To modify
    strategy: depend
``` 

where: 

- `YOUR-NEW-PROJECT` is the name of the project that you would like to add. This will only be used to name this job in the pipeline, it doesn't have to correspond exactly to the project name. 

- `PROJECT-STAGE` is the stage of the CI. Typically, one of: `data_run`, `process_run`, 
`parameter_run`, `method_run`, `metric_run` or `summary_run`. The order

- `PROJECT_PATH` is the path to the project, relative to (and including) the namespace it is located. 

2) [Only if the project was NOT created from an Omnibenchmark template] 
In the `.gitlab-ci.yml` file of the project to integrate, remove the current content and replace it with the [YAML for Omnibenchmark projects ](https://github.com/omnibenchmark/contributed-project-templates/blob/main/omni-data-py/.gitlab-ci.yml) (universal for any Omnibenchmark and project).


3) Trigger your project using your pipeline schedule (see previous section if you haven't set it up). 

### How can I activate the orchestrator ? 

Go to the renkulab page of the orchestrator project > `CI/CD` > `Schedules`. There, you can activate 
an existing scheduler, modify it, or add a new one. 




