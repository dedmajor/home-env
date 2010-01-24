# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

umask 002

export LANG=en_US.UTF8

alias h='history'
alias j='jobs -pl'
alias whois='jwhois'
alias du='du -h'
alias df='df -h'

# simple console variant of baobab gnome-util
alias dux='du / 2>/dev/null | egrep "[0-9]([0-9]{2}M|G)"'

alias cd...='cd ../..'
alias cd..='cd ..'
alias cd.='cd .'
alias cd~='cd ~'
alias cd-='cd -'
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias ~='cd ~'

# gentoo colorful defaults:
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias l="ls -lah"
alias ll="ls -lh"

# grep trick by dedmajor
# simple but more comfortable variant of ack search tool
function gr()
{
	OPTS=""
	while [ "${1:0:1}" == "-" ]; do
		OPTS="$OPTS $1"
		shift
	done

	WORD="$1";
	shift
	
	find ${@:-.} -path '*/.svn' -prune -o -type f -print0 \
		| xargs -0 grep --color=auto -I $OPTS "$WORD"
}

# todo: pushd/popd bindings

export CDPATH=".:~/svn:/var/www"

# gentoo-style colorful prompt:
export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] "

export PATH="~/bin/:~/local/bin/:${PATH}"

if [ ${BASH_VERSION%.*.*} -gt 3 ]; then
	# bash 4.0 new features
	shopt -s autocd
	shopt -s cdspell
	shopt -s dirspell
	shopt -s checkjobs
	shopt -s globstar
fi