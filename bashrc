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
	local path="$(basename "$(dirname "$PWD")")/$(basename "$PWD")"
	path=$(color "$cyan" "$path")
	if [[ $EUID -eq 0 ]]; then
		chr="$(color "$red" '#')"
	else
		chr="$"
	fi
	PS1="$(color "$white" "[")${branch}${path}$(color "$white" "]${chr}") "
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
alias youtubedownload='youtube-dl -x --audio-format mp3' # youtubedownload url

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
