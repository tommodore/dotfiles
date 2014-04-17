if [ -f ~/.rvm/scripts/'rvm' ]; then
  source ~/.rvm/scripts/'rvm'
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=/usr/local/bin:$PATH
PATH=/usr/local/bin:/usr/local/sbin:$PATH
