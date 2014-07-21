setopt prompt_subst
autoload -U promptinit && promptinit


# ZSH_THEME_GIT_PROMPT_NOCACHE=1

# left
#PROMPT='%{$FG[226]%}%(!.#.⚡)%{$reset_color%} '
# PROMPT='%{$FG[007]%}%n@%m%{$FG[015]%}: %{$FG[003]%}%30<...<%c%<<%u%{$reset_color%}   $(git_super_status)
# %{$FG[007]%}%D{%H:%M}%{$reset_color%} $ '

# right
#RPROMPT='%{$fg_bold[blue]%}%m%{$fg_bold[white]%}:%{$fg_bold[cyan]%}%30<...<%~%<<%u%{$reset_color%}$(git_super_status)'

prompt pure
