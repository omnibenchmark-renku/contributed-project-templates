#!/usr/bin/python
import sys as sys
import omni_sparql as omni
import re
import json
import argparse
from datetime import datetime
import os as os
import glob as glob

parser = argparse.ArgumentParser()
parser.add_argument("-e", "--endpoint", help="Triplestore endpoint URL", default = "http://imlspenticton.uzh.ch/sparql")
parser.add_argument("-noDs", "--no_ds_in_params", help="Remove dataset from parameter ?", type = bool, default = True)
parser.add_argument("-o", "--output_name", help="name of JSON output")
parser.add_argument('-i', '--input', nargs='+', default=[], help = "list of metric files")
                    
args = parser.parse_args()
ENDPOINT = args.endpoint
NO_DS_IN_PARAMS = args.no_ds_in_params
OUT_JSON = args.output_name
INPUT = args.input

print("endpoint:", ENDPOINT)
print("no ds:", NO_DS_IN_PARAMS)
print("out:", OUT_JSON)
print("int:", INPUT[0:4], "...[truncated]")
## ONLY FOR TESTING ------------------------------------------------------------------------
# INPUT = ['data/cms_py/cms_py_inst0_omni_mnn_py_inst0_cellbench_data_py___order_size__hvg_all__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst1_omni_mnn_py_inst0_cellbench_data_py___order_size__hvg_all__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst2_omni_mnn_py_inst0_cellbench_data_py___order_size__hvg_sig__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst3_omni_mnn_py_inst0_cellbench_data_py___order_size__hvg_sig__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst4_omni_mnn_py_inst0_cellbench_data_py___order_size__hvg_none__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst5_omni_mnn_py_inst0_cellbench_data_py___order_size__hvg_none__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst6_omni_mnn_py_inst0_cellbench_data_py___order_inverse__hvg_all__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst7_omni_mnn_py_inst0_cellbench_data_py___order_inverse__hvg_all__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst8_omni_mnn_py_inst0_cellbench_data_py___order_inverse__hvg_sig__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst9_omni_mnn_py_inst0_cellbench_data_py___order_inverse__hvg_sig__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst10_omni_mnn_py_inst0_cellbench_data_py___order_inverse__hvg_none__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst11_omni_mnn_py_inst0_cellbench_data_py___order_inverse__hvg_none__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst12_omni_mnn_py_inst0_cellbench_data_py___order_auto__hvg_all__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst13_omni_mnn_py_inst0_cellbench_data_py___order_auto__hvg_all__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst14_omni_mnn_py_inst0_cellbench_data_py___order_auto__hvg_sig__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst15_omni_mnn_py_inst0_cellbench_data_py___order_auto__hvg_sig__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst16_omni_mnn_py_inst0_cellbench_data_py___order_auto__hvg_none__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst17_omni_mnn_py_inst0_cellbench_data_py___order_auto__hvg_none__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst18_omni_mnn_py_inst1_csf_patient_py___order_size__hvg_all__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst19_omni_mnn_py_inst1_csf_patient_py___order_size__hvg_all__d_30__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst20_omni_mnn_py_inst1_csf_patient_py___order_size__hvg_sig__d_10__k_20_corrected_dim_file_metric_res.json', 'data/cms_py/cms_py_inst21_omni_mnn_py_inst1_csf_patient_py___order_size__hvg_sig__d_30__k_20_corrected_dim_file_metric_res.json']

# Triplestore endpoint for queries
# ENDPOINT = "http://imlspenticton.uzh.ch/omni_batch_py_sparql"
# remove dataset from parameter ? (assumes that name is 'dataset_name')
# NO_DS_IN_PARAMS = True
# name of output JSON
# OUT_JSON = "test.json"

## ---------------------------------------------------------------------------------


json_out = dict()
val_nam = []
dir_names = []
for NAM in INPUT:
    
    print("Getting summary info for:", NAM)
    # TODO: recognize if not in graph and next + warning (do with cms here)
    # TODO: add option to add other info such as date created, time run,e tc...?
    # TODO: atm, removes automatically 'dataset_name' from parameters
    # TODO: see how it handles if some results were generated with different parameters
    # TODO: see if 'processed/meta_' still a problem in new triplestore
    # TODO: parallelization for speed
    
    # DIRECTORY: save for latter to retrieve _info
    dir_i = os.path.dirname(NAM)
    if dir_i not in dir_names: 
        dir_names.append(dir_i)
    
    # METRIC: original project from file
    query = omni.getSparqlQuery.project_from_file(NAM)
    out = omni.query_from_sparql(query, URL = ENDPOINT)
    # ignore this iteration if nothing is found
    if len(out) == 0: 
        continue
    else: 
        METRIC = out[0]['project_name']['value']
        val_nam.append(NAM)
    
    # METHOD: get  input file and retrieve which project it comes from
    query = omni.getSparqlQuery.input_from_file(NAM)
    method_file = omni.query_from_sparql(query, URL = ENDPOINT)[0]['out']['value']
    query = omni.getSparqlQuery.project_from_file(method_file)
    METH = omni.query_from_sparql(query, URL = ENDPOINT)[0]['project_name']['value']
    
    # DATASET: iterate until no results, then get original project 
    query = omni.getSparqlQuery.input_from_file(NAM)
    orig_file = omni.query_from_sparql(query, URL = ENDPOINT)[0]['out']['value']
    while True: 
        query = omni.getSparqlQuery.input_from_file(orig_file)
        orig_file = omni.query_from_sparql(query, URL = ENDPOINT)
        if len(orig_file) > 0: 
            temp_file = orig_file[0]['out']['value']
            ## ---------------------------------------------------
            # TEMP: problem with processed/meta_ which is imported & placed in the wrong folder.
            # Should be resolved with new tripletore.
            if temp_file.find("processed/meta_") > 0:
                ind = 1
                while True: 
                    temp_file = orig_file[ind]['out']['value']
                    if ind > len(orig_file): 
                        break
                    if temp_file.find("processed/meta_") > 0: 
                        ind +=1
                        continue
                    else: 
                        break
            ## ---------------------------------------------------
            orig_file = temp_file
            raw_file = temp_file
            continue
        else: 
            break
    
    query = omni.getSparqlQuery.project_from_file(raw_file)
    DATASET = omni.query_from_sparql(query, URL = ENDPOINT)[0]['project_name']['value']
    
    # PARAMETERS: done on the method_file
    query = omni.getSparqlQuery.parameters_from_file(method_file, params_only = True)
    params = omni.query_from_sparql(query, URL = ENDPOINT)
    params_nam = [x['paramPrefix']['value'] for x in params]
    params_nam = [re.sub('^--', '', i) for i in params_nam]
    params_nam = [re.sub('=$', '', i) for i in params_nam]
    PARAM_LIST = dict(zip(params_nam, 
                [x['params']['value'] for x in params]))
    if NO_DS_IN_PARAMS: 
        if 'dataset_name' in PARAM_LIST.keys(): 
            del PARAM_LIST['dataset_name']
    
    # RUN TIME: info from activity
    query = omni.getSparqlQuery.activity_from_file(method_file)
    act = omni.query_from_sparql(query, URL = ENDPOINT)
    start = act[0]['startTime']['value'].replace("+00:00", "Z")
    start = datetime.strptime(start,"%Y-%m-%dT%H:%M:%SZ" )
    end = act[0]['endTime']['value'].replace("+00:00", "Z")
    end = datetime.strptime(end,"%Y-%m-%dT%H:%M:%SZ" )
    RUNTIME = (end-start).total_seconds()
    
    # CREATE JSON
    json_out[NAM] = {
    "dataset": [
        DATASET
    ], 
    "method": [
        METH
    ], 
    "parameter": 
    PARAM_LIST, 
    "metric": [
        METRIC
    ],
    "runtime": [
        RUNTIME
    ]
    }
    
print('Done!')
# write down results
json_out = json.dumps(json_out, indent = 3)
with open(OUT_JSON+".json", "w") as outfile:
    outfile.write(json_out)
    
  


# check if we have 1 info file per directory
for i in dir_names:
    ifile = glob.glob(i + "/*_info.json")
    if len(ifile) != 1: 
        sys.exit("Too many info files detected for " + ifile )

info_json = dict()
info_json["info_file"] = [glob.glob(x + "/*_info.json") for x in dir_names]
info_json["info_file"] = [''.join(x) for x in info_json["info_file"] ]
info_json = json.dumps(info_json, indent = 3)
with open(OUT_JSON+"_info.json", "w") as outfile:
    outfile.write(info_json)

