# Load package
library(optparse)

# Get list with command line arguments by name
option_list = list(
    make_option(c("--argument_name"), type="character", default=NULL, 
              help="Description of the argument", metavar="character")
); 
 
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

# An useful error if the argument is missing
if (is.null(opt$argument_name)){
  print_help(opt_parser)
  stop("Argument_name needs to be specified, but is missing.n", call.=FALSE)
}

# Call the argument
arg1 <- opt$argument_name