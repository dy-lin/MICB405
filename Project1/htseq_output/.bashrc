# .bashrc

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Custom prompt
# PS1="[ \[\e[1;36m\]\u\[\e[33m\]@\[\e[35m\]\h\[\e[33m\]:\[\e[32m\] \W \[\e[0m\]] \$\[\e[0m\] "

# shopt -s checkwinsize
BLUE="\[\033[1;36m\]"
YELLOW="\[\033[33m\]"
PURPLE="\[\033[35m\]"
GREEN="\[\033[32m\]"
WHITE="\[\033[0m\]"

PS1="$WHITE[ $BLUE\u$YELLOW@$PURPLE\h$YELLOW: $GREEN\w $WHITE] $WHITE\$ "

# User specific aliases and functions
alias wmi='readlink -f $(pwd)'
alias path='readlink -f'
alias vimr='vim -M'
alias tsv="column -t -s$'\t'"
alias rmdiff='grep -Fvxf'
alias time_it='/usr/bin/time -pv'
if [[ "$HOSTNAME" == dlin02* ]]
then
#	alias ls='ls -FhG'
	alias ls='ls -hG'
else
	alias ls='ls -h --color=auto'
fi


function path() {
	if [[ "$HOSTNAME" != dlin02* ]]
	then
		if [[ "$#" -ne 1 ]]
		then
			readlink -f .
		else
			if [[ -e $1 ]]
			then
				readlink -f $1
			else
				echo "$1 does not exist in the specified directory."
			fi
		fi
	else
		if [[ "$#" -eq 0 ]]
		then
			pwd
		else
		#	if [[ ! -e "$1" ]]
		#	then
		#		echo "$(pwd)/$1"
		#	else
			echo "$(pwd)/$1"
		#	fi
		fi
	fi
}

function cdd() {
	if [[ "$1" == */ ]]
	then
		arg=$(echo $1 | sed 's/\/$//')
	else
		arg=$1
	fi
	if [[ ! -d "$arg" ]]
	then
		if [[ -L "$arg" ]]
		then
			dir=$(dirname $(readlink -f $arg))
		else
			dir=$(dirname $arg)
		fi
	else
		if [[ -L "$arg" ]]
		then
			dir=$(readlink -f $arg)
		else
			dir=$arg
		fi
	fi

	cd $dir
}

# MAN PAGE COLOR CODING
export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\E[01;33m'
# export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
# export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_ue=$'\e[0m'
 export LESS_TERMCAP_us=$'\E[01;36m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'

umask ug+rw
