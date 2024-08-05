#!/usr/bin/env bash
#
# Some reusable functions.

set -e

# Expose all utility constants and functions
source "$(dirname "$0")"/util/colors.sh
source "$(dirname "$0")"/util/format.sh
source "$(dirname "$0")"/util/log.sh

die() {
	error $@
	exit 1
}

edo() {
	if (( $DRY_RUN )); then
		dry_run $@
	else
		trace $@
		# NOTE: `eval $@` would break spaces in arguments.
		eval $(printf '%q ' "$@")
	fi
	return $?
}

ask_yes_no() {
  question ${1:?}
	local yes_no_default=${2:?} yes_no_answer

	printf "${NEWLINE_MARGIN}${BCyan}Answer (y|N): "
	read -n 1 yes_no_answer
	printf "${Color_Off}\n"
	case "${yes_no_answer:-${yes_no_default}}" in
		y|Y) return 0 ;;
		n|N|*) return 1 ;;
	esac
}

if_yes() {
  local q=${1:?}
	local yes_no_default=${2:?}
	shift 2
	ask_yes_no "$q" "$yes_no_default" && edo $@
}
