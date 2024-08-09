#!/usr/bin/env bash
#
# Some reusable functions.

# Expose all utility constants and functions.
BASH_TOOLBOX="${SCRIPTS_ROOT:?}"/bash-toolbox
source "${BASH_TOOLBOX}"/colors.sh
source "${BASH_TOOLBOX}"/die.sh
source "${BASH_TOOLBOX}"/edo.sh
source "${BASH_TOOLBOX}"/format.sh
source "${BASH_TOOLBOX}"/log.sh
source "${BASH_TOOLBOX}"/yes_no.sh
