#!/bin/bash
source "$(dirname "$0")/../lib/argparser.bash"

# Define options
# args must be in this sequens -> "short form" "long form" "has argument" "description" "optional/required" "type(you can ignore this)" "default value (you can ignore this also)"

# a required flag with type of 'file' which takes value and no 'default value'
define_option "f"   "file"      "yes"   "Input file"        "required"  "file"      ""

# an optional flag with type of 'number' which takes value and with 'default value' of '21'
define_option "n"   "number"    "yes"   "Number of threads" "optional"  "number"    "21"

# an optional flag with type of 'dir' which takes value and without 'default value'
define_option "d"   "directory" "yes"   "Input directory"   "optional"  "dir"       "" 

# an optional flag without type (it can take anything as value) which takes value and without 'default value'
define_option "s"   "label"     "yes"   "Label name"        "optional"  ""          ""

# an optional flag without type which does not takes value (its boolean) and without 'default value' (if provides then its value will be set to 'true')
define_option "v"   "verbose"   "no"    "Enable verbose"    "optional"  ""          ""


# Parse arguments
parse_args "$@"

# Access parsed arguments
echo "File:   ${ARGS[file]}"
echo "Number: ${ARGS[number]}"
echo "Label:  ${ARGS[label]}"
echo "Verbose: ${ARGS[verbose]}"
echo "directory: ${ARGS[directory]}"
