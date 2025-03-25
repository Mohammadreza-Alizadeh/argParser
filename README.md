# Arg Parser


A reusable, type-aware argument parser for Bash scripts

i didn't find a minimal and no-dependency module to use when my scripts need `Argument Parsing`, so here we are.

with this script you can easily manage your script `argument parsing` logic, just define the option you want to recive from user and let the script handle its validation
for anyone wonders, this script is influenced from `python's argparse`    
## 🧩 Features

- Short & long flags (e.g. `-f` and `--file`)
- Required and optional arguments
- Argument types: `dir`, `number`, `file`
- Flag safety: avoids consuming other flags as values
- Auto help generation


## 🚀 Usage

```bash
source ./lib/argparser.bash

define_option "f" "file" "yes" "Input file" "required" "file"
define_option "n" "number" "yes"  "Number of threads" "optional" "file"

parse_args "$@"

echo "File: ${ARGS[file]}"
echo "Threads: ${ARGS[number]}"
```

Run the example:
```bash
bash examples/demo.sh --file ./somefile.txt --number 5
```
