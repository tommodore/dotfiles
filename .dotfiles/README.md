# Dotfiles Repo

This repo holds my cross-platform setup for zsh (with Starship prompt), Neovim (LazyVim), Wezterm, and a few utils like fzf/zoxide/mise. It's a bare Git repo for clean symlinks—no junk in your home dir. Works on macOS and Linux, with XDG paths for everything (e.g., .zshrc lives in `~/.config/zsh/`).

## Structure
- `.zshenv`: Sets XDG vars and ZDOTDIR for zsh.
- `.config/zsh/.zshrc`: Core zsh config (history, completions, aliases, keybinds).
- `.config/starship/starship.toml`: Prompt with Catppuccin colors and ligatures.
- `.config/nvim/`: Full LazyVim distro (plugins auto-install on first run).
- `.config/wezterm/wezterm.lua`: Terminal config.

## Prerequisites
- Git (for the repo).
- Zsh (default on macOS; `sudo apt install zsh` on Ubuntu/Debian).
- Terminal: Wezterm (install via brew/apt—see setup below).
- Nerd Font (for ligatures/icons): On Mac `brew install font-hack-nerd-font`; on Linux `sudo apt install fonts-hack-nerd-font`.

## Setup
Run these as your user. Assumes a fresh machine—back up any old configs first.

### General (Both OS)
1. Clone the bare repo:
   ```
   git clone --bare https://github.com/tommodore/dotfiles.git $HOME/.dotfiles
   ```
2. Set up alias and config:
   ```
   alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
   dotfiles config --local status.showUntrackedFiles no
   ```
3. Checkout (symlinks files):
   ```
   dotfiles checkout
   ```
   - Conflicts? Move old files: `mv ~/.zshrc ~/.zshrc.old`.
4. Add alias to shell (edit `.zshenv` or run it manually):
   ```
   echo "alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> ~/.zshenv
   ```
5. Install tools (see OS sections).
6. Reload shell: `exec zsh`.
7. Test: Open new terminal—Starship prompt should show. Run `nvim` for LazyVim (plugins install on first launch).

### macOS-Specific
- Homebrew: Install if missing (`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`).
- Tools:
  - Starship: `brew install starship`.
  - fzf/zoxide: `brew install fzf zoxide`.
  - Mise: `curl https://mise.run | sh`.
  - Neovim: `brew install neovim`.
  - Wezterm: `brew install --cask wezterm`.
- Set zsh default: `chsh -s /bin/zsh` (log out/in).

### Linux-Specific (Ubuntu/Debian Example)
- Tools:
  - Starship: `sudo apt install starship` (or curl install script).
  - fzf: `sudo apt install fzf`.
  - Zoxide: `curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh`.
  - Mise: `curl https://mise.run | sh`.
  - Neovim: `sudo apt install neovim`.
  - Wezterm: `sudo apt install wezterm` (or download deb from site).
- Set zsh default: `chsh -s $(which zsh)` (log out/in).
- For other distros: Swap `apt` for `dnf` (Fedora) or `pacman` (Arch).

## Usage
- Pull updates: `dotfiles pull origin main`.
- Commit changes: `dotfiles add <file> && dotfiles commit -m "msg" && dotfiles push`.
- Status: `dotfiles status`.

## Troubleshooting
- **Prompt broken?** Check Starship: `starship prompt`. Reload: `exec zsh`.
- **Neovim fails?** Nuke caches: `rm -rf ~/.local/{share,state,cache}/nvim`, then `nvim` (reinstalls plugins). Needs Neovim 0.9+.
- **Ligatures missing?** Switch terminal font to Hack Nerd Font.
- **XDG issues?** Verify: `echo $ZDOTDIR` should be `~/.config/zsh`.

Fork or tweak as needed—keeps my machines in sync.
