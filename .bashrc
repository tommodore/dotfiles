# Bash Completion

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi
if [ -f ~/dotfiles/bash/.git-completion.bash ]; then
  source ~/dotfiles/bash/.git-completion.bash
fi
if [ -f ~/dotfiles/bash/bash-git-prompt/gitprompt.sh ]; then
  source ~/dotfiles/bash/bash-git-prompt/gitprompt.sh
fi

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/heroku/bin:$PATH
export GIT_PS1_SHOWDIRTYSTATE=1
