sudo pacman -S zsh # Install zsh
chsh -s $(which zsh) # Change the default shell to zsh
mkdir .zsh # Create .zsh directory in ~
# Then clone the repositories into .zsh folder:

git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
