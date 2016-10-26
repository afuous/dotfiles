#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
source /usr/share/nvm/init-nvm.sh

prompt_command() {
	local branch=$(git branch 2> /dev/null | grep '*' | cut -c 3-)
	if [[ ! -z "$branch" ]]; then
		if [[ ! -z $(git status | grep '^Changes to be committed:$') ]]; then
			branch="$branch+"
		fi
		if [[ ! -z $(git status | grep '^Changes not staged for commit:$') ]]; then
			branch="$branch*"
		fi
		branch="($branch) "
	fi
	PS1="[${branch}$(basename $(dirname "$PWD"))/$(basename "$PWD")]$ "
}
PROMPT_COMMAND=prompt_command

export VISUAL=vim
export EDITOR="$VISUAL"

alias hs='runhaskell'
alias clip='xclip -sel clip'
alias chrome='google-chrome-stable'
