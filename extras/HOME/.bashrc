#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set vi mode
# set -o vi

# Define Editor
export EDITOR=nvim

export HISTSIZE=5000
export HISTFILESIZE=500
export HISTTIMEFORMAT="%F %T" # add timestamp to history

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Allow ctrl-S for history navigation (with ctrl-R)
[[ $- == *i* ]] && stty -ixon

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rate-mirrors='rate-mirrors --entry-country "South Africa" --disable-comments-in-file arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
alias nv='$EDITOR'
alias vim='$EDITOR'
alias vi='$EDITOR'
alias e='nvim '
alias se='sudo -e' # sudo -e # sudoedit is the other command that can be used
alias bd='cd "$OLDPWD"'  # cd into the old directory
alias chu='checkupdates'
alias dou='sudo pacman -Syu --noconfirm'
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias df='df -h'    # human-readable sizes
alias lsn='lsof -i'
alias ist='speedtest-cli'
alias wtr='curl wttr.in/walvis+bay current'
alias wtra='~/weather1.py current'
alias ntrf='netstat -lantp | grep -i stab | awk -F/ "{print $2 $3}" | sort | uniq'
alias la='exa -a --icons --group-directories-first'    # all files and dirs
alias ll='exa -Alh --git --icons --group-directories-first'    # long format with header
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias fzf='fzf --preview="bat --color=always {}"'
alias fzn='nvim $(fzf -m --preview="bat --color=always {}")'
alias fzs='sudo -e $(fzf -m --preview="bat --color=always {}")'

# PS1='[\u@\h \W]$ '
# PS1='[\u@\h \W]➜ '

### Bash shell integrations ###

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Setup starship integration in bash
eval "$(starship init bash)"
# Set up fzf key bindings and fuzzy completion in bash
eval "$(fzf --bash)"
# Setting fzf to search by extension
export FZF_DEFAULT_OPTS="--extended"
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude ".snapshots"'
# export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Setup xoxide
eval "$(zoxide init bash)"
# Run pfetch
pfetch
