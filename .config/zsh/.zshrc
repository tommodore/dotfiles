# ~/.config/zsh/.zshrc
# Clean Zsh Configuration

# =============================================================================
# ENVIRONMENT & PATH
# =============================================================================
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less -R"

# Add local bin and mise shims
export PATH="$HOME/.local/bin:$HOME/.config/mise/shims:$PATH"

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.local/cache"

# =============================================================================
# HISTORY
# =============================================================================
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$XDG_DATA_HOME/zsh/history"

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# =============================================================================
# COMPLETIONS & KEYBINDINGS
# =============================================================================
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# fzf integration (if installed)
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# zoxide (smart cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# =============================================================================
# STARSHIP PROMPT
# =============================================================================
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# =============================================================================
# ALIASES - CORE TOOLS
# =============================================================================

# --- Navigation & Files ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --icons --level=2'
alias ltg='eza --tree --icons --git-ignore'
alias ltr='eza -l --sort=modified --reverse --icons'     # like ls -ltr

alias cat='bat --style=plain'
alias less='bat --paging=always'

# --- Git (lazygit + useful aliases) ---
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias lg='lazygit'                    # Open lazygit
alias lgd='lazydocker'                # Open lazydocker

# --- Docker ---
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# --- Mise (version manager) ---
alias m='mise'
alias mi='mise install'
alias ml='mise list'
alias mu='mise use'
alias mr='mise run'

# --- Productivity ---
alias o='obsidian'                    # Quick open Obsidian (if in PATH or alias)
alias ray='open -a Raycast'           # Launch Raycast
alias hs='open -a Hammerspoon'        # Open Hammerspoon console

# --- Communication ---
alias slack='open -a Slack'
alias tg='open -a Telegram'
alias sig='open -a Signal'
alias wa='open -a WhatsApp'

# --- Browsers ---
alias chrome='open -a "Google Chrome"'
alias ff='open -a Firefox'
alias brave='open -a Brave\ Browser'

# --- Networking ---
alias ts='tailscale'
alias tsst='tailscale status'
alias tsup='tailscale up'

# --- System ---
alias reload='source ~/.config/zsh/.zshrc && echo "Zsh config reloaded"'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# =============================================================================
# FUNCTIONS
# =============================================================================

# Quick Obsidian daily note (customize path if needed)
daily() {
  local date=$(date +%Y-%m-%d)
  open "obsidian://open?vault=Personal&file=Daily%20Notes/${date}"
}

# Quick project jump with zoxide + fzf
pj() {
  local dir
  dir=$(zoxide query -l | fzf --height 40% --reverse)
  [ -n "$dir" ] && cd "$dir"
}

# Git commit with conventional message
gcm() {
  if [ -z "$1" ]; then
    echo "Usage: gcm <type> <message>"
    echo "Types: feat, fix, docs, style, refactor, test, chore"
    return 1
  fi
  git commit -m "$1: $2"
}

# Docker cleanup
dclean() {
  docker system prune -af --volumes
  echo "Docker cleaned up"
}

# Tailscale quick connect
tsquick() {
  tailscale up --accept-routes --accept-dns
  echo "Tailscale connected"
}

# =============================================================================
# FINAL TOUCHES
# =============================================================================

# System info on startup
fastfetch

# Source any local overrides
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
