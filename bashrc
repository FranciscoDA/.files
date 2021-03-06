#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias wttrin='curl wttr.in/~Lujan_Buenos_Aires_Argentina'

__git_ps1() {
	last_status="$?"
	branch="$(git branch --show-current 2>/dev/null)"
	if [ -n "$branch" ]; then
		if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
			wdstatus='*'
		fi
		echo -e " [\001\e[32m\002$branch\001\e[93m\002$wdstatus\001\e[0m\002]"
	fi
	return "$last_status"
}

PS1='\[\e[94m\]\u@\h\[\e[0m\] \[\e[1;36m\]\W\[\e[0m\]$(__git_ps1) $(test $? == 0 && echo ''\[\e[32m\]✓'' || echo ''\[\e[31m\]×'')\[\e[0m\] '
