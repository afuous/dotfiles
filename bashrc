#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

color() {
	echo "\[\e[$1m\]$2\[\e[m\]"
}

prompt_command() {

	local white="1;37"
	local cyan="1;36"
	local red="1;31"
	local green="1;32"
	local yellow="1;33"

	local branch=$(git branch 2> /dev/null | grep '*' | cut -c 3-)
	if [[ ! -z "$branch" ]]; then
		branch=$(color "$green" "$branch")
		if [[ ! -z $(git status 2> /dev/null | grep '^Changes to be committed:$') ]]; then
			branch="${branch}$(color "$red" "+")"
		fi
		if [[ ! -z $(git status 2> /dev/null | grep '^Changes not staged for commit:$') ]]; then
			branch="${branch}$(color "$red" "*")"
		fi
		branch="$(color "$white" "(")${branch}$(color "$white" ")") "
	fi

	local venv=''
	if [[ "$VIRTUAL_ENV" ]]; then
		venv="$(color "$white" "(")$(color "$yellow" "venv")$(color "$white" ")") "
	fi

	local dirname="$(basename "$PWD")"
	if [ "$dirname" == '/' ]; then dirname=''; fi
	local prevdirname="$(basename "$(dirname "$PWD")")"
	if [ "$prevdirname" == '/' ]; then prevdirname=''; fi
	local path="$prevdirname/$dirname"
	path=$(color "$cyan" "$path")

	local chr="$(color "$white" '$')"
	if [[ $EUID -eq 0 ]]; then
		chr="$(color "$red" '#')"
	fi

	PS1="$(color "$white" "[")${branch}${venv}${path}$(color "$white" "]")${chr} "
}
PROMPT_COMMAND=prompt_command

export VISUAL=vim
export EDITOR="$VISUAL"

alias hs='runhaskell'
alias clip='xclip -sel clip'
alias clippng='xclip -sel clip -t image/png'
alias pasteclip='xclip -o -sel clip'
alias pasteclippng='xclip -o -sel clip -t image/png'
alias chrome='google-chrome-stable'
alias latexopen='~/dotfiles/bin/latex-open.sh'
alias slatexopen='~/dotfiles/bin/synctex-latex-open.sh'
alias gdb='gdb -q'
alias za='zathura'
alias mvdownload='~/dotfiles/bin/mvdownload.sh'
alias youtubedownload='youtube-dl -f bestaudio' # youtubedownload url

gitdiff() {
	git diff --color $@ | less -R
}

node() {
	if [ $# -eq 0 ] && which rlwrap > /dev/null 2> /dev/null; then
		NODE_NO_READLINE=1 rlwrap "$(which node)"
	else
		"$(which node)" $@
	fi
}

dotglob() {
	if [ $# == 0 ]; then
		shopt -s dotglob
	elif [ "$1" == 'off' ]; then
		shopt -u dotglob
	else
		echo 'Usage: dotglob or dotglob off'
	fi
}

# go() {
# 	if [[ ! -e "$@" ]] || [[ -f "$@" ]]; then
# 		vim "$@"
# 	elif [ -d "$@" ]; then
# 		cd "$@"
# 	else
# 		echo "$@ is not a file nor a directory"
# 	fi
# }

# THIS COMMAND TAKES HALF A SECOND TO RUN WHEN OPENING A NEW BASH SESSION
# https://github.com/Microsoft/WSL/issues/776
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# if [[ $EUID -ne 0 ]]; then
# 	tmux 2> /dev/null
# fi

export PATH="$HOME/.yarn/bin:$PATH"
