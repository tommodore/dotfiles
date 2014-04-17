# Bash Completion

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi
if [ -f ~/dotfiles/bash/.git-completion.bash ]; then
  . ~/dotfiles/bash/.git-completion.bash
fi
if [ -f ~/dotfiles/bash/bash-git-prompt/gitprompt.sh ]; then
  . ~/dotfiles/bash/bash-git-prompt/gitprompt.sh
fi


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

#PS1 Prompt
export GIT_PS1_SHOWDIRTYSTATE=1
