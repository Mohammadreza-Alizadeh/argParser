#!/bin/bash

declare -A ARGS
REQUIRED_OPTIONS=()
OPTIONS=()

define_option() {
	local short="$1"
	local long="$2"
	local takes_arg="$3"
	local desc="$4"
	local required="$5"
	local type="$6"
	local default_val="$7"

	OPTIONS+=("$short|$long|$takes_arg|$desc|$required|$type|$default_val")
	[[ "$required" == "required" ]] && REQUIRED_OPTIONS+=("$long")
}

set_defaults() {
	for opt in "${OPTIONS[@]}"; do
		IFS="|" read -r short long takes_arg desc required type default_val <<<"$opt"
		if ! [[ -z "$default_val" ]]; then
			ARGS["$long"]="$default_val"
		fi
	done
}
generate_help() {
	echo "Usage: $0 [OPTIONS]"
	echo
	for opt in "${OPTIONS[@]}"; do
		IFS="|" read -r short long takes_arg desc required type default_val <<<"$opt"
		local req_label=""
		[[ "$required" == "required" ]] && req_label="(required)"
		local arg_label=""
		local type_help_message=""
		local default_value_message=""
		if ! [[ -z "$default_val" ]]; then
			default_value_message="default : $default_val "
		fi
		if [[ "$takes_arg" == "yes" ]]; then
			if ! [[ -z "$type" ]]; then
				arg_label=" <$type>"
				type_help_message="| value must be a valid $type"
			else
				arg_label=" <value>"
			fi
		fi
		printf "  -%s, --%s%s\t%s %s %s %s\n" "$short" "$long" "$arg_label" "$desc" "$req_label" "$default_value_message" "$type_help_message"
	done
	exit 0
}

validate_type() {
	local val="$1"
	local type="$2"
	local long="$3"

	case "$type" in
	number)
		[[ "$val" =~ ^[0-9]+$ ]] || {
			echo "❌ Error: --$long expects a number, got '$val'"
			exit 1
		}
		;;
	file)
		[[ -f "$val" ]] || {
			echo "❌ Error: --$long expects an existing file, got '$val'"
			exit 1
		}
		;;
	dir)
		[[ ! -d "$val" ]] && echo "❌ Error: --$long must be a directory" && exit 1
		;;
	"") ;;
	*)
		echo "❌ Unknown type '$type' for --$long"
		exit 1
		;;
	esac
}

parse_args() {
	set_defaults
	while [[ $# -gt 0 ]]; do
		case "$1" in
		-h | --help)
			generate_help
			;;
		-*)
			arg="$1"
			value="$2"
			matched=false

			for opt in "${OPTIONS[@]}"; do
				IFS="|" read -r short long takes_arg desc required type default_val <<<"$opt"
				if [[ "$arg" == "-$short" || "$arg" == "--$long" ]]; then
					matched=true
					if [[ "$takes_arg" == "yes" ]]; then
						if [[ -z "$value" || "$value" == -* ]]; then
							echo "❌ Error: --$long requires a non-flag value"
							exit 1
						fi
						validate_type "$value" "$type" "$long"
						ARGS["$long"]="$value"
						shift
					else
						ARGS["$long"]=true
					fi
					break
				fi
			done

			if [[ "$matched" == false ]]; then
				echo "❌ Unknown option: $arg"
				exit 1
			fi
			;;
		*)
			echo "❌ Unrecognized argument: $1"
			exit 1
			;;
		esac
		shift
	done

	for req in "${REQUIRED_OPTIONS[@]}"; do
		if [[ -z "${ARGS[$req]}" ]]; then
			echo "❌ Error: --$req is required"
			echo
			generate_help
			exit 1
		fi
	done
}
