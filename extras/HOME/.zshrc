# Created by newuser for 5.9.2

export EDITOR=nvim

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
unsetopt beep
bindkey -v

# Aliases
alias grep='grep --color=auto'
alias nv='nvim'
alias snv='sudo nvim'
alias ff='fzf --preview="bat --color=always {}"'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias upgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

eval "$(starship init zsh)"

# 1. Configure zsh-completions (Must be added BEFORE compinit)
# fpath=(~/.zsh/plugins/zsh-autosuggestions/src $fpath)
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Initialize the completion system
autoload -Uz compinit
compinit

# 2. Configure zsh-syntax-highlighting (Must be at the very END of the file)
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 3. Enable fzf key bindings and auto-completion
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Change fdfind to fd if you are not on Ubuntu/Debian
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .snapshots"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .snapshots"
