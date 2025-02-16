[ -n "${ZSH:?}" ]
export KEEP_ZSHRC=true
sh -c "$(wget -qO https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -)"

# NOTE: Disabled because I use Starship now instead.
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$ZSH/custom}/themes/powerlevel10k"
