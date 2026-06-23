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
alias cp='cp -rpi'
alias df='df -h'
alias mv='mv -i'
alias rm='rm -i'
alias ls='eza -a --color=auto --group-directories-first'    # Ensure "eza" is installed.
alias ll='eza -ahl --color=auto --group-directories-first'  # Ensure "eza" is installed.
alias ff='fzf --preview="bat --color=always {}"'
alias grep='grep --color=auto'
alias chkup="checkupdates"
alias pacsyu='sudo pacman -Syyu'				            # update only standard pkgs
alias yaysua='yay -Sua --noconfirm'				            # update only AUR pkgs
alias upgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'	# update grub
alias unlock='sudo rm /var/lib/pacman/db.lck'			    # remove pacman lock
alias z='zoxide'
alias sb='source .bashrc'

# PS1='[\u@\h \W]\$ '
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\u@\h \W]\\$ \[$(tput sgr0)\]"

export MANPAGER="bat -l man -p"

export LIBVIRT_DEFAULT_URI='qemu:///system'

# Setting Ctrl+T to apply to FZF_DEFAULT_COMMAND.
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Setting find as the default command for fzf and ignore files (like '.gitignore'),
# display hidden files, and exclude the '.git' directory. (Ensure "find" is installed)
# export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/.snapshots/*'"

# Setting fd as the default command for fzf and ignore files (like '.gitignore'),
# display hidden files, and exclude the '.git' directory. (Ensure "fd" is installed)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude ".snapshots"'

# Setting ripgrep as the default command for fzf and ignore files (like '.gitignore'),
# display hidden files, and exclude the '.git' directory.(Ensure "ripgrep" is installed)
# export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.snapshots"'

# Setup starship integration in bash
eval "$(starship init bash)"
# Setup neovim integration in bash
eval "$(fzf --bash)"
# Setup zoxide integration in bash
eval "$(zoxide init bash)"

# Troubleshoot Shell Keybind Clashes
# Run bind -X | grep fzf to check if "\C-t" maps to fzf-file-widget
# The reult must be:
# "\C-r" "__fzf_history__"
# "\C-t" "fzf-file-widget"
# if not then
# Manually map Ctrl+T to the fzf file search function
bind -x '"\C-t": fzf-file-widget'

