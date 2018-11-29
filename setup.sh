#!/bin/sh

echo "Installing Xcode Tools"
xcode-select --install

echo "Setting up ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ./doubleend.zsh-theme  ~/.oh-my-zsh/themes/
# TODO: Figure out how to set .termianl theme programatically
cp ./.zshrc ~/.zshrc 

echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

echo "Installing CLI tools"
brew install thefuck
brew install autojump

echo "Installing applications with cask"
brew cask install google-chrome
brew cask install visual-studio-code
brew cask install slack
brew cask install spotify

