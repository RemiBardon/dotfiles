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
		eval $@
	fi
	return $?
}
