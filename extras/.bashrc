#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Define Editor
export EDITOR=nvim


alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rate-mirrors='rate-mirrors --entry-country "South Africa" --disable-comments-in-file arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
alias nv='$EDITOR'
alias vim='$EDITOR'
alias vi='$EDITOR'
alias df='df -h'    # human-readable sizes
alias la='exa -a --icons --group-directories-first'    # all files and dirs
alias ll='exa -Alh --git --icons --group-directories-first'    # long format with header
alias se='sudo -e'    # sudoedit is the other command that can be used
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock

# PS1='[\u@\h \W]$ '
PS1='[\u@\h \W]➜ '

eval "$(starship init bash)"

source ~/.local/share/blesh/ble.sh
