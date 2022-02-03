# {{ name }}
{% if description %}
{{ description }}
{% endif %}

## Processed dataset template

Template to process raw dataset from omnibenchmark projects. The template assumes that you uploaded datasets to Renku using the [`omnibench_dataset`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-dataset) template or a similar project. 

This template explains how to import the desired datasets and process them uniformly before passing them to the methods. As an example, this template shows how to perform normalization, HVG, PCA, TSNE, UMAP on a dummy dataset of the same style as for the `omnibench_dataset`. 

## Steps to process your omnibenchmark data

### 1. Initialize your new project

**Ignore this step if you have already imported this template on Renku.**

I. On the Renku page, click *new project*. 

II. In the fields, paste: 

- an *omnibenchmark* project group, or your own namespace (default) in `Namespace`,

- `https://github.com/ansonrel/contributed-project-templates` in `Repository URL`,

-  `main` in the `Repository Reference`,

-  `fetch templates`

-  `Custom - Basic omnibenchmark processing` as a template. 

-  Some description of your project that will be passed at the begining of this readme. 

III. Start a new environment in the `Environments` tab of your Renku project.

### 2. Process the data

I. If needed, **modify the `process_data.R`** script that processes the data by default with: 

- normalization (`logNormCounts`)

- Identification of top highly variable genes (`getTopHVGs`) 

- Dimension reduction (`runPCA`, `runUMAP`)

II. **Fill in the fields in the `src/config.sh`**. The most important fields are

- `OMNI_DATA_RAW`, a keyword that should match the tag that you defined in your renku data project(s). We encourage you to check your keyword by passing it to this link: `https://renkulab.io/knowledge-graph/datasets?query=` and check that the desired datasets are retrieved with your query. 

- `OMNI_DATA_PROCESSED`, the keyword that will be latter used by the methods to query the processed data. Typically it is the tag that you used for your raw data, followed by `_processed`.

III. Run `bash src/process_data.sh`. Once finished, your processed data are uploaded to renku and available for the next step of omnibenchmark. 

### 3. Next: defining parameters and methods

Go to: 

- the [`parameters template`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-param) to define the parameter space. You can create a new project from a template [here](https://renkulab.io/projects/new?data=eyJ1cmwiOiJodHRwczovL2dpdGh1Yi5jb20vYW5zb25yZWwvY29udHJpYnV0ZWQtcHJvamVjdC10ZW1wbGF0ZXMiLCJyZWYiOiJtYWluIiwidGVtcGxhdGUiOiJDdXN0b20vb21uaWJlbmNoLXBhcmFtIn0%3D)

- the [`methods template`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-method) to add your method's wrappers. 



