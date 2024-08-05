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
	if [[ $DRY_RUN ]]; then
		dry_run $@
	else
		trace $@
		# NOTE: `eval $@` would break spaces in arguments.
		eval $(printf '%q ' "$@")
	fi
	return $?
}

if_yes() {
	local yes_no_default=${1:?} yes_no_answer
	shift 1

	printf "${NEWLINE_MARGIN}${BCyan}Answer (y|N): "
	read -n 1 yes_no_answer
	printf "${Color_Off}\n"
	case "${yes_no_answer:-${yes_no_default}}" in
		y|Y) edo $@ ;;
		n|N|*) return 1 ;;
	esac
}
