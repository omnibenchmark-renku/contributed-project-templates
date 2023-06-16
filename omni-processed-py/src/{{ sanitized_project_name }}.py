# Load module
import argparse

# Get command line arguments and store them in args
parser=argparse.ArgumentParser()
parser.add_argument('--argument_name', help='Description of the argument')
args=parser.parse_args()

# Call the argument
arg1 = args.argument_name