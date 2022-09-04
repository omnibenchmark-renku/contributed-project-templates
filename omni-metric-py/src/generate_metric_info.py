import argparse
import json

parser=argparse.ArgumentParser()
parser.add_argument('--metric_info', help='Path to the metric info json file')
args=parser.parse_args()

metric_info = {
    ## All these options are used by the `bettr` package. 
    ## See its documentation for more details. 
    # minimum value of the metric
    'min': 0,
    # flip: Logical scalar; whether or not to flip the sign of the metric values
    'flip': True,
    # maximum value of the metric
    'max': 1,
    # group of the metric. Can be used to group metrics on the bettr app
    'group': "default",
    # prefix to recognize the required input files from the methods results for the metric
    'input': "PREFIX", 
    # do not modify. 
    'name': "̣{{__sanitized_project_name__}}"
}

with open(args.metric_info, "w") as fp:
    json.dump(metric_info , fp, indent=3) 
