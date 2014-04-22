export ZSH=~/dotfiles/zsh

# Load all of the config files in that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# RVM ZSH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# PATH
pathdirs=(
  /usr/local/heroku/bin
  /opt/local/bin
  /opt/local/sbin
  /usr/local/bin
  /usr/local/sbin
  ~/bin
)
for dir in $pathdirs; do
    if [ -d $dir ]; then
        PATH=$dir:$PATH
    fi
done
export PATH

# Load and run compinit
autoload -U compinit
compinit -i

