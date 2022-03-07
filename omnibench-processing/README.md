# {{ name }}
{% if description %}
{{ description }}
{% endif %}

## Processed dataset template

Template to process raw dataset from omnibenchmark projects. The template assumes that you uploaded datasets to Renku using the [`omnibench_dataset`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-dataset) template or a similar project. 

This template explains how to import the desired datasets and process them uniformly before passing them to  methods. As an example, this template shows how to perform normalization, HVG, PCA, TSNE, UMAP on a dummy dataset of the same style as for the `omnibench_dataset`. 

## Steps to process your omnibenchmark data

### 1. Initialize your new project

**Ignore this step if you have already imported this template on Renku.**

I. Log in to [Renku](https://renkulab.io)

II. Create a new omnibenchmark dataset project using [this link](https://renkulab.io/projects/new?data=eyJ1cmwiOiJodHRwczovL2dpdGh1Yi5jb20vYW5zb25yZWwvY29udHJpYnV0ZWQtcHJvamVjdC10ZW1wbGF0ZXMiLCJyZWYiOiJtYWluIiwidGVtcGxhdGUiOiJDdXN0b20vb21uaWJlbmNoLXByb2Nlc3NpbmcifQ%3D%3D).

III. Fill in the empty fields. Some description of your project that will be passed at the begining of this readme and the tag of the raw data to fetch. If needed, you can change them latter in the `src/config.sh`  file. 

IV. Go to the `Environments` tab of your new Renku project and launch a new session when the Docker image has been built. 

### 2. Process the data

I. If needed, **modify the `process_data.R`** script. By default, the provided script processes the data with: 

- normalization (`logNormCounts`)

- Identification of top highly variable genes (`getTopHVGs`) 

- Dimension reduction (`runPCA`, `runUMAP`)

II. If you haven't provided the metadata during the creation of the project or if you want to modify them: check the `src/config.sh` file. Be especially aware of: 

- `OMNI_DATA_RAW`, a keyword that should match the tag that you defined in your renku data project(s). We encourage you to check your keyword by passing it to this link: `https://renkulab.io/knowledge-graph/datasets?query=` and check that the desired datasets are retrieved with your query. 

- `OMNI_DATA_PROCESS`, the keyword that will be latter used by the methods to query the processed data. Typically it is the tag that you used for your raw data, followed by `_processed`.

III. Run `bash src/run_project.sh`. Once finished, your processed data are uploaded to renku and available for the next step of omnibenchmark. 

### 3. Next: defining parameters and methods

Go to: 

- the [`parameters template`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-param) to define the parameter space. You can create a new project from a template [here](https://renkulab.io/projects/new?data=eyJ1cmwiOiJodHRwczovL2dpdGh1Yi5jb20vYW5zb25yZWwvY29udHJpYnV0ZWQtcHJvamVjdC10ZW1wbGF0ZXMiLCJyZWYiOiJtYWluIiwidGVtcGxhdGUiOiJDdXN0b20vb21uaWJlbmNoLXBhcmFtIn0%3D)

- the [`methods template`](https://github.com/ansonrel/contributed-project-templates/tree/main/omnibench-method) to add your method's wrappers. 



