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

### I'm an **Omnibenchmark developper** and would like to add a project to the orchestrator 

**Prerequisites**: Make sure that the project was already run once and is functional. 

**If the project to integrate was set up using an Omnibenchmark template**, you can ignore step 2).  

1) In the `.gitlab-ci.yml` file of the orchestrator, add: 

```
trigger_YOUR-NEW-PROJECT:
  stage: PROJECT-STAGE
  only:
    - schedules
  trigger: 
    project: PROJECT_PATH
    strategy: depend
``` 

where: 

- `YOUR-NEW-PROJECT` is the name of the project that you would like to add. 

- `PROJECT-STAGE` is the stage of the CI. Typically, one of: `data_run`, `process_run`, 
`parameter_run`, `method_run`, `metric_run` or `summary_run`.

- `PROJECT_PATH` is the path to the project, relative to (and including) the namespace it is located. 


2) In the `.gitlab-ci.yml` file of the project to integrate, remove the current content and replace it with the [YAML for Omnibenchmark projects ](https://github.com/ansonrel/contributed-project-templates/blob/main/omni-data-py/.gitlab-ci.yml) (universal for any Omnibenchmark and project).


3) [To do only once when setting-up a new orchestrator] Setup the tokens that will give the access to the triggered projects.

On the renkulab page of the orchestrator, on the toolbar on the right-hand side, go to `settings` > `CI/CD` > `Variables` 
and under `Add variable`, add: 

- your personal access token in there and **name it `CI_PUSH_TOKEN`** [1]

- the token to populate the omnibencmark triplestore (contact dev team) and **name it `OMNI_UPDATE_TOKEN`**

[1] If you don't own such token, you can create one by following 
[these instructions](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) and 
select at least "api, read api" as scope. 

### How can I activate the orchestrator ? 

Go to the renkulab page of the orchestrator project > `CI/CD` > `Schedules`. There, you can activate 
an existing scheduler, modify it, or add a new one. 




