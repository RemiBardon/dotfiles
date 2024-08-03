#!/usr/bin/env bash
#
# Some functions to help formatting.

format_secondary() {
	printf "${DWhite}$*${Color_Off}"
}
format_url() {
	printf "${Underline}$*${Underline_Off}"
}
