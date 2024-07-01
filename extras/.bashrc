#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Define Editor
export EDITOR=nvim

export HISTSIZE=2000
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
alias bd='cd "$OLDPWD"'  # cd into the old directory
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'    # human-readable sizes
alias la='exa -a --icons --group-directories-first'    # all files and dirs
alias ll='exa -Alh --git --icons --group-directories-first'    # long format with header
alias se='sudo -e'    # sudoedit is the other command that can be used
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias rmd='/bin/rm  --recursive --force --verbose '  # Remove a directory and all files

# PS1='[\u@\h \W]$ '
# PS1='[\u@\h \W]➜ '

### Bash shell integrations ###

# Setup starship integration in bash
eval "$(starship init bash)"
# Set up fzf key bindings and fuzzy completion in bash
eval "$(fzf --bash)"
# Setup xoxide
eval "$(zoxide init bash)"
# Setup ble autocompletin n bash
# source ~/.local/share/blesh/ble.sh
# Run pfetch
pfetch
