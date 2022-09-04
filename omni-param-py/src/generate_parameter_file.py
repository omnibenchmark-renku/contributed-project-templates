
import argparse
import json

parser=argparse.ArgumentParser()
parser.add_argument('--param_json', help='Path to the output json file')
args=parser.parse_args()

# Define here parameters used by one or multiple methods
param_space = {
    'PARAM1': [],
    'PARAM2': [1],
    #...
}

with open(args.param_json, "w") as fp:
    json.dump(param_space , fp, indent=3) 
