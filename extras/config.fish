if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
set TERM "xterm-256color"   # Sets the terminal type

alias fishy='vim ~/.config/fish/config.fish'
alias rate-mirrors='rate-mirrors --entry-country "South Africa" --disable-comments-in-file arch --max-delay 7200 | sudo tee /etc/pacman.d/mirrorlist'
alias ll='eza -alF --color=always --group-directories-first' # my preferred listing

### CUSTOM FUNCTIONS ###

# Custom Function for a sudo !! replacement

function sudo --description "replacement for 'sudo !!' command to run last command using sudo"
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

# Endo of sudo !! function

# Custom function for listing ram hogs
function memhogs
    ps axh -o cmd:15,%mem --sort=-%mem | head | string trim
end

# Custom function for listing cpu hogs
function cpuhogs
    ps axh -o cmd:15,%cpu --sort=-%cpu | head
end

# Function to print percent used hdd space of home folder
function hdd
    df -h /home | grep /dev | awk '{print $3 "/" $5}'
end

