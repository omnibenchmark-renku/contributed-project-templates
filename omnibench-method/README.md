# {{ name }}
{% if description %}
{{ description }}
{% endif %}

## Methods template

Template to add the methods that you would like to evaluate. The template assumes that **processed** datasets and parameter space projects were already created using your omnibenchmark tag.  

The method that will be added here will be applied to **all** processed datasets using the same tag. 

## Steps to process your omnibenchmark data

### 1. Initialize your new project

**Ignore this step if you have already imported this template on Renku.**

I. Log in to [Renku](https://renkulab.io)

II. Create a new omnibenchmark method project using [this link](https://renkulab.io/projects/new?data=eyJ1cmwiOiJodHRwczovL2dpdGh1Yi5jb20vYW5zb25yZWwvY29udHJpYnV0ZWQtcHJvamVjdC10ZW1wbGF0ZXMiLCJyZWYiOiJtYWluIiwidGVtcGxhdGUiOiJDdXN0b20vb21uaWJlbmNoLW1ldGhvZCJ9).

III. Fill in the empty fields. Some description of your project that will be passed at the begining of this readme and the metadata of your parameters. You can change them latter in the `src/config.sh` file. 

III. Start a new environment in the `Environments` tab of your Renku project.

### 2. Process the data

I. If not done previously, fill in the metadata fields in the `src/config.sh` or proofread the fields that you indicated. Most importantly, **add the tag corresponding to your benchmark**, which corresponds to the tag used for the desired datasets and parameters and which should be used for the metric. 

Also add the parameter names that were defined in your parameter project and that could be used with this method. For each one, define the default values (used latter for visualization purposes).

II. Run `bash src/run_{{ meth_name }}.sh`. Once finished, this will result files in a new folder in your `data/`.

### 3. Next: add metrics.  

COMING SOON. 



