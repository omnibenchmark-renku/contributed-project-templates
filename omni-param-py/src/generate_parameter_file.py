
import argparse
import json

parser=argparse.ArgumentParser()
parser.add_argument('--param_json', help='Path to the output json file')
args=parser.parse_args()

## DEFINE YOUR PARAMETERS HERE -------------------------------------------------
# Define here parameters used by one or multiple methods of an omnibenchmark. 
# If the parameters cannot be defined in a list, please contact the dev. team.
param_space = {
    ## EXAMPLE
    # 'PARAM1': [-1, 0, -1],
    # 'PARAM2': ['a', 'b', 'c'],
    #...
}
## -----------------------------------------------------------------------------

with open(args.param_json, "w") as fp:
    json.dump(param_space , fp, indent=3) 
