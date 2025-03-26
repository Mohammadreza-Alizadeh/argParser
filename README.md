# Bash script ArgParser

A reusable, type-aware argument parser for Bash scripts to help you undrestand what a user say

i didn't find a minimal and no-dependency module to use when my scripts need `Argument Parsing`, so here we are.

with this script you can easily manage your script `argument parsing` logic, just define the option you want to recive from user and let the script handle its validation
for anyone wonders, this script is influenced from `python's argparse`    
## 🧩 Features

- Short & long flags (e.g. `-f` and `--file`)
- Required and optional arguments
- Argument types: `dir`, `number`, `file`
- Flag safety: avoids consuming other flags as values
- Auto help generation



## 🧩 Usage

### 🏗 Define Options

Use the `define_option` function:

```bash
define_option SHORT LONG HAS_ARG DESCRIPTION REQUIRED TYPE DEFAULT
```

| Parameter     | Description                                      |
|---------------|--------------------------------------------------|
| `SHORT`       | Single-letter flag (e.g. `f` for `-f`)           |
| `LONG`        | Long-form flag (e.g. `file` for `--file`)        |
| `HAS_ARG`     | `"yes"` if flag takes an argument, otherwise `"no"` |
| `DESCRIPTION` | Help description shown to users                 |
| `REQUIRED`    | `"required"` or `"optional"`                     |
| `TYPE`        | `file`, `number`, `dir`, or leave empty for any |
| `DEFAULT`     | Default value if not provided (optional only)    |

### 🧪 Example

```bash
define_option "f" "file" "yes" "Input file" "required" "file" ""
define_option "n" "number" "yes" "Number of threads" "optional" "number" "21"
define_option "d" "directory" "yes" "Input directory" "optional" "dir" ""
define_option "s" "label" "yes" "Label name" "optional" "" ""
```

---

### 🚀 Parsing and Accessing Values

```bash
parse_args "$@"
echo "${ARGS[file]}"
echo "${ARGS[number]}"
```


see the `examples` directory for a in action use of script

