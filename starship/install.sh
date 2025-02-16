set -eu

SCRIPTS_ROOT="$(dirname "$0")"/../scripts
BASH_TOOLBOX="${SCRIPTS_ROOT:?}"/bash-toolbox
source "${BASH_TOOLBOX}"/edo.sh

brew_install() {
	edo brew list --versions "$@" \>/dev/null || edo brew install "$@" \>/dev/null
}

brew_install --formula starship
brew_install --cask font-fira-code-nerd-font
