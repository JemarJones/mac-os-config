echo "Installing Xcode Tools"
xcode-select --install

echo "Setting up ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ./doubleend.zsh-theme  ~/.oh-my-zsh/themes/
# TODO: Figure out how to set .termianl theme programatically

echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install thefuck
brew install autojump

