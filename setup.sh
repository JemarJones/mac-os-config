#!/bin/sh
# This hasnt been tested yet.. good luck

echo "Installing homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing applications with brew cask..."
brew cask install google-chrome
brew cask install visual-studio-code
brew cask install alfred
brew cask install shiftit
brew cask install slack
brew cask install spotify

echo "Installing CLI tools..."
brew install thefuck
brew install autojump

echo "Setting up Terminal..."
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Setup zsh
# Use the install command to copy instead of cp and set permissions correctly.
# We need to do this because when we curl the git repo everything gets 755 which is no beuno
install -m 644 ./config/doubleend.zsh-theme  ~/.oh-my-zsh/themes/
echo "TODO: Figure out how to set .terminal theme programatically"
# TODO: Figure out how to set .terminal theme programatically
install -m 644 ./config/.zshrc ~/.zshrc
install -m 644 ./config/.vimrc ~/.vimrc

echo "Installing node..."
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

nvm install node
nvm use node
nvm alias default node
brew install yarn --without-node

source ~/.zshrc

echo "Finishing touches..."
code --install-extension Shan.code-settings-sync

mkdir -p ~/Documents/Projects

echo "All done!"
echo "PS: Remember to sync vs code with https://gist.github.com/JemarJones/2ad56fe8690d0f3126948e70bef65c65"

