# ~/.zshrc

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# OS detection for cross-platform
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS: Homebrew setup (works for both Intel and Apple Silicon)
  if [[ -x "$(command -v brew)" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  # Linux: nothing extra needed here
fi

# History settings (shared)
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completions (faster init, cross-platform)
autoload -Uz compinit
compinit -C

# Version manager (mise, if installed)
if [[ -x "$(command -v mise)" ]]; then
  eval "$(mise activate zsh)"
fi

# Prompt: Starship (cross-platform, fast)
if [[ -x "$(command -v starship)" ]]; then
  eval "$(starship init zsh)"
fi

# Tools (if installed)
if [[ -x "$(command -v fzf)" ]]; then
  eval "$(fzf --zsh)"
fi
if [[ -x "$(command -v zoxide)" ]]; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Keybindings (Emacs-style, cross-platform)
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Completions styling (simple, uses LS_COLORS if available)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Aliases (essentials)
alias ls='ls --color=auto'
alias vim='nvim'
alias c='clear'
alias starship-config='nvim ~/.config/starship/starship.toml'
