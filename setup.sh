#!/bin/sh
# This hasnt been tested yet.. good luck

echo "Installing Xcode Tools..."
xcode-select --install

echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

echo "Installing applications with brew cask..."
brew cask install google-chrome
brew cask install visual-studio-code
brew cask install alfred
brew cask install slack
brew cask install spotify

echo "Installing CLI tools..."
brew install thefuck
brew install autojump

echo "Setting up ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ./doubleend.zsh-theme  ~/.oh-my-zsh/themes/
echo "TODO: Figure out how to set .terminal theme programatically"
# TODO: Figure out how to set .terminal theme programatically
cp ./.zshrc ~/.zshrc

echo "Installing nvm..."
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

echo "Reloading ~/.zshrc..."
source ~/.zshrc

echo "Installing node..."
nvm install node
nvm use node
nvm alias default node

echo "All done!"
echo "PS: Remember to get the VS Code Sync Settings Extension and sync with https://gist.github.com/JemarJones/2ad56fe8690d0f3126948e70bef65c65"

