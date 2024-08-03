#!/usr/bin/env bash
#
# Some reusable functions.

set -e

source "$(dirname "$0")"/util/colors.sh

LOG_TRACE=${LOG_TRACE:-0}
LOG_DEBUG=${LOG_DEBUG:-1}
LOG_INFO=${LOG_INFO:-1}
LOG_WARN=${LOG_WARN:-1}
LOG_DRY_RUN=${LOG_DRY_RUN:-${LOG_TRACE}}

NEWLINE_MARGIN="          "

trace() {
	(( $LOG_TRACE )) && printf "  ${DWhite}[${Purple}TRACE${DWhite}]${Color_Off} $(format_secondary $*)\n" || return 0
}
debug() {
	(( $LOG_DEBUG )) && printf "  ${DWhite}[${White}DEBUG${DWhite}]${Color_Off} ${Black}${On_Yellow}$*${Color_Off}\n" || return 0
}
info() {
	(( $LOG_INFO )) && printf "   ${DWhite}[${Blue}INFO${DWhite}]${Color_Off} $*\n" || return 0
}
warn() {
	(( $LOG_WARN )) && printf "   ${DWhite}[${Yellow}WARN${DWhite}]${Color_Off} $*\n" || return 0
}
error() {
	printf "  ${DWhite}[${Red}ERROR${DWhite}]${Color_Off} $*\n"
}
success() {
	printf "     ${DWhite}[${Green}OK${DWhite}]${Color_Off} $*\n"
}
question() {
	printf "    ${DWhite}[${Cyan}???${DWhite}]${Color_Off} $*\n"
}
dry_run() {
	# NOTE: Remove leading underscore-prefixed functions, to avoid logging things like `_log_as_info`.
	local command=$(echo $* | sed -E 's/^(_[a-zA-Z0-9_]* )+//')
	(( $LOG_DRY_RUN )) && printf "${DWhite}[${White}DRY_RUN${DWhite}]${Color_Off} sh> $(format_secondary $command)\n" || return 0
}

_log_as_trace() {
	$@ | while read -r line; do trace "$line"; done
}
_log_as_debug() {
	$@ | while read -r line; do debug "$line"; done
}
_log_as_info() {
	$@ | while read -r line; do info "$line"; done
}
_log_as_warn() {
	$@ | while read -r line; do warn "$line"; done
}
_log_as_error() {
	$@ | while read -r line; do error "$line"; done
}
_log_as_success() {
	$@ | while read -r line; do info "$line"; done
}
