# Bash Completion

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f ~/dotfiles/.git-completion.bash ]; then
    . ~/dotfiles/.git-completion.bash
fi

# Load in the git branch prompt script.
source ~/dotfiles/bash-git-prompt/gitprompt.sh
