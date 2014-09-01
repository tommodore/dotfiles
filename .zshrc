export ZSH=~/dotfiles/zsh
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Load all of the config files in that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i
