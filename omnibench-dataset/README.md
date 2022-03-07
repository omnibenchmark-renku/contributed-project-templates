# {{ name }}
{% if description %}
{{ description }}
{% endif %}

## Dataset template

Template to add a dataset to an omnibenchmark project. For each dataset that you have, **one dedicated repository** has to be created from this template to upload the data on the renku system. 

## Steps to add your own data to omnibenchmark on Renku

### 1. Initialize your new project

**Ignore this step if you have already imported this template on Renku.**

I. Log in to [Renku](https://renkulab.io)

II. Create a new omnibenchmark dataset project using [this link](https://renkulab.io/projects/new?data=eyJ1cmwiOiJodHRwczovL2dpdGh1Yi5jb20vYW5zb25yZWwvY29udHJpYnV0ZWQtcHJvamVjdC10ZW1wbGF0ZXMiLCJyZWYiOiJtYWluIiwidGVtcGxhdGUiOiJDdXN0b20vb21uaWJlbmNoLWRhdGFzZXQifQ%3D%3D).

III. Fill in the empty fields. Some description of your project that will be passed at the begining of this readme and the metadata of your data. If needed, you can change them latter in the `src/config.sh`  and `src/{{ __sanitized_project_name__ }}` file. 

IV. Go to the `Environments` tab of your new Renku project and launch a new session when the Docker image has been built. 

### 2. Format data

I. In your interactive environment, download and process your data with `src/{{ __sanitized_project_name__ }}.{{ script_language }}` by completing the code. If multiple scripts are needed, `src/{{ project_name }}.{{ script_language }}` should be the main script executing them. Also, it should accept a `--dataset_name` argument for the naming of the output. 

You can check how the data can look like using the `dummy_data()` function (included in the `src/{{ __sanitized_project_name__ }}.R` code) and run `dummy_data(write_data=TRUE)` if you want to see how the output files should look like, namely: 

- `counts_{{ __sanitized_project_name__ }}.mtx.gz`: a sparse matrix of the count data (genes x cells)

- `feature_{{ __sanitized_project_name__ }}.json`: a JSON file created from the features metadata of your dataset (e.g. `rowData`) with the first column containing non-duplicated ENSEMBL IDs of the genes. Other columns can optionally be added for example gene symbols etc. 

- `meta_{{ __sanitized_project_name__ }}.json`: a JSON file created from the cells metadata of your dataset (e.g. `colData`) with the first column containing non-duplicated barcodes assigned to the cells. Other columns can optionally be added for example sample, condition, patient, etc. 

- `data:info_{{ __sanitized_project_name__ }}.json`: a dataset metadata file with at least, a *link*, *tissue*, *description* and *note* fields (see the first lines of `{{ __sanitized_project_name__ }}.R`).

Please note that **any processing steps (filtering, doublets removal) that will not be evaluated in the benchmark should be done in this repo**. Likewise, if you want to assess the effect of processing later on, don't include these steps yet.

II. If you haven't provided the metadata during the creation of the project or if you want to modify them: check the `src/config.sh` file. Be especially aware of: 

- `IN_PREFIX['data_generation_script']` : which **should match your data generation script**. It will allow to track any changes to it and rerun the workflow should it be modified. 

- `TAG_LIST=("")`: this is the keyword(s) defining your dataset. There is typically 1 keyword per omnibenchmark pipeline (e.g. "normalization_benchmark"), which allows any of its components to query all data with this keyword. 

### 3. Load your data in Renku

Simply run `bash src/run_project.sh` in a terminal once you have correctly formated the data and filled in the metadata fields. The origin of your dataset is now tracked by Renku and you can use it for the next steps. 

### 3B. Update your data

In the case where you need to update your data (e.g. updated source data, metadata, etc), simply run: 

`bash src/run_project.sh`

after your changes to update the desired files. 

### 4. Process the dataset

If you have added all dataset that you need for your benchmark, continue with the next step of omnibenchmark: [the processing of your data](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-processing)


