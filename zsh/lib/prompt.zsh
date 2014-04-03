setopt prompt_subst
autoload -U promptinit
promptinit


# PROMPT='[%n@%m %~${vcs_info_msg_0_}] %{$reset_color%}'
PROMPT='$FG[003]%~ %{$reset_color%} $(git_super_status)
$FG[007]%D{%H:%M}%{$reset_color%} $ '
# PROMPT='%B%m%~%b$(git_super_status) %# '
