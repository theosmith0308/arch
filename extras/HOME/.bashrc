#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Define Editor
export EDITOR=nvim

export HISTSIZE=5000
export HISTFILESIZE=500
export HISTTIMEFORMAT="%F %T" # add timestamp to history

# Aliases
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

alias e='nvim '
alias se='sudo -e' # sudo -e # sudoedit is the other command that can be used
alias vi='vim'
alias svi='sudo vim'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='eza -1a --color=auto --group-directories-first'
alias ll='eza -ahl --color=auto --group-directories-first'
alias ff='fzf --preview="bat --color=always {}"'
alias grep='grep --color=auto'
alias chkup="checkupdates"
alias pacsyu='sudo pacman -Syyu'				            # update only standard pkgs
alias yaysua='yay -Sua --noconfirm'				            # update only AUR pkgs
alias upgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'	# update grub
alias unlock='sudo rm /var/lib/pacman/db.lck'			    # remove pacman lock
alias sb='source .bashrc'

# PS1='[\u@\h \W]\$ '
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\u@\h \W]\\$ \[$(tput sgr0)\]"

export LIBVIRT_DEFAULT_URI='qemu:///system'

# Setting find as the default source for fzf
export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/.snapshots/*'"

# Setting Ctrl+T to apply to FZF_DEFAULT_COMMAND and to ignore certain directories
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Setup starship integration in bash
eval "$(starship init bash)"
# Setup neovim integration in bash
eval "$(fzf --bash)"

