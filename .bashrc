# Bash Completion

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f ~/dotfiles/bash/.git-completion.bash ]; then
    . ~/dotfiles/bash/.git-completion.bash
fi
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/heroku/bin:$PATH
export GIT_PS1_SHOWDIRTYSTATE=1

# Load in the git branch prompt script.
source ~/dotfiles/bash/bash-git-prompt/gitprompt.sh
