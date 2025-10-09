# ~/.zshenv
# XDG setup for cross-platform
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Zsh XDG compliance
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# History file (keeps it out of ~ too)
mkdir -p "$XDG_STATE_HOME/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# Reload shell after this: exec zsh
