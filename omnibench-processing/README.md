# {{ name }}
{% if description %}
{{ description }}
{% endif %}
## Dataset template

Template to process raw dataset from omnibenchmark projects. The template assumes that you uploaded dataset to Renku using the [`omnibench_dataset`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-dataset) template or similar project. 

This template explains how to import the desired datasets and process them uniformly before passing them to the methods. As an example, this template shows how to perform normalization, HVG, PCA, TSNE, UMAP on a dummy dataset of the same style as for the `omnibench_dataset`. 

## Steps to process your omnibenchmark data

### 1. Initialize your new project

I. On the Renku page, click *new project*. 

II. In the fields, paste: 

- [omni_data](https://renkulab.io/gitlab/omnibenchmark/omni_data), a similar *omnibenchmark* project group, or your own namespace in `Namespace`,

- `https://github.com/ansonrel/contributed-project-templates` in `Repository URL`,

-  `main` in the `Repository Reference`,

-  `Custom - Basic omnibenchmark processing` as a template. 

III. Start a new environment in the `Environments` tab of your Renku project.

### 2. Format data

I. In your interactive environment, download and process your data with `src/{{ name }}.R` by completing the code. You can check how the data can look like using the `dummy_data()` function (included in the code), namely: 

- `counts_{{ name }}.mtx.gz`: a sparse matrix of the count data (genes x cells)

- `feature_{{ name }}.json`: a JSON file created from the features metadata of your dataset (e.g. `rowData`) with the first column containing non-duplicated ENSEMBL IDs of the genes. Other columns can optionally be added for example gene symbols etc. 

- `meta_{{ name }}.json`: a JSON file created from the cells metadata of your dataset (e.g. `colData`) with the first column containing non-duplicated barcodes assigned to the cells. Other columns can optionally be added for example sample, condition, patient, etc. 

- `data:info_{{ name }}.json`: a dataset metadata file with at least, a *link*, *tissue*, *description* and *note* fields (see the first lines of `{{ name }}.R`).

Please note that **any processing steps (filtering, doublets removal) that will not be evaluated in the benchmark should be done in this repo**. Likewise, if you want to assess the effect of processing later on, don't include these steps yet.

II. Fill in the metadata in the `config.sh` and in the R script. 

### 3. Load your data in Renku

Simply run `bash src/load_dataset.sh` once you have correctly formated the data and filled in the metadata fields. The origin of your dataset is now tracked by Renku and you can use it for the next steps. 


