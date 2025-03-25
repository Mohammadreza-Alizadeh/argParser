#!/bin/bash
source "$(dirname "$0")/../lib/argparser.bash"

# Define options
# args must be in this sequens -> "short form" "long form" "has argument" "description" "optional/required" "type(you can ignore this)"
define_option "f"   "file"      "yes"   "Input file"        "required"  "file"
define_option "n"   "number"    "yes"   "Number of threads" "optional"  "number"
define_option "d"   "directory" "yes"   "Input directory"   "optional"  "dir"
define_option "s"   "label"     "yes"   "Label name"        "optional"
define_option "v"   "verbose"   "no"    "Enable verbose"    "optional"
define_option "h"   "help"      "no"    "Show help"         "optional"

# Parse arguments
parse_args "$@"

# Access parsed arguments
echo "File:   ${ARGS[file]}"
echo "Number: ${ARGS[number]}"
echo "Label:  ${ARGS[label]}"
echo "Verbose: ${ARGS[verbose]}"
echo "directory: ${ARGS[directory]}"
