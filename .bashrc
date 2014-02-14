# Bash Completion

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

shopt -s promptvars dotglob histappend no_empty_cmd_completion cdspell xpg_echo

function parse_git_dirty {
  echo -n $(git status 2>/dev/null | awk -v out=$1 -v std="dirty" '{ if ($0=="# Changes to be committed:") std = "uncommited"; last=$0 } END{ if(last!="" && last!="nothing to commit (working directory clean)") { if(out!="") print out; else print std } }')
}
function parse_git_branch {
  echo -n $(git branch --no-color 2>/dev/null | awk -v out=$1 '/^*/ { if(out=="") print $2; else print out}')
}
function parse_git_remote {
  echo -n $(git status 2>/dev/null | awk -v out=$1 '/# Your branch is / { if(out=="") print $5; else print out }')
}
export PS1='$(ppwd \l)\u@\h:\[33[33m\]\w\[33[0m\]$(parse_git_branch ":")\[33[36m\]$(parse_git_branch)\[33[0m\]$(parse_git_remote "(")\[33[35m\]$(parse_git_remote)\[33[0m\]$(parse_git_remote ")")\[33[0m\]$(parse_git_dirty  "[")\[33[31m\]$(parse_git_dirty )\[33[0m\]$(parse_git_dirty  "]")>'
