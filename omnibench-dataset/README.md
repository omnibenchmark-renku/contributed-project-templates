# {{ name }}
{% if description %}
{{ description }}
{% endif %}
## Dataset template

Template to add a dataset to an omnibenchmark project. For each dataset that you have, **one dedicated repository** has to be created from this template to upload the data on the renku system. 

## Steps to add your own data to the own omnibenchmark project on Renku

### 1. Initialize your new project

I. On the Renku page, click *new project*. 

II. In `Namespace`, select [omni_data](https://renkulab.io/gitlab/omnibenchmark/omni_data) or a similar *omnibenchmark* project group.

II. In `Template Source` select `Custom`.

III. In `Repository URL`, paste `https://github.com/ansonrel/contributed-project-templates` , pass `master` in the `Repository Reference` and `Custom - Basic omnibenchmark dataset` as a template. 

IV. Start a new environment in the `Environments` tab of your Renku project.

### 2. Process data

I. In your interactive environment, download and process your data with `src/data.R` by completing the code. You can check how the data can look like using the `dummy_data()` function (included in the code). Please not that **any processing steps (filtering, doublets removal) that will not be evaluated in the benchmark should be done in this script**. Likewise, if you want to assess the effect of processing, don't include these steps yet.

II. Fill in the metadata in the `load_data.sh` and in the R script. 
