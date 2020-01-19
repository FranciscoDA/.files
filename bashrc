#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[94m\]\u@\h\[\e[0m\] \[\e[1;36m\]\W\[\e[0m\] $(test $? == 0 && echo ''\[\e[32m\]✓'' || echo ''\[\e[31m\]×'')\[\e[0m\] '
