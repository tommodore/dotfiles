# Bash Completion

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/git-completion.bash
fi
if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh]; then
  . /usr/local/etc/bash_completion.d/git-prompt.sh
fi

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$PATH
export GIT_PS1_SHOWDIRTYSTATE=1

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\
  [\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
