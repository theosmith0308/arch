#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ram='rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist'
alias sgm='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias dbl='sudo rm /var/lib/pacman/db.lck'
alias df='df -Th'
PS1='[\u@\h \W]\$ '
