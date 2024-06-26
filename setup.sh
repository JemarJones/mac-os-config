#!/bin/zsh

# Pretty info throughout the process
print_info () {
  printf "\e[32m=======> %s <=======\e[m\n" "$1"
}

print_warning () {
  printf "\e[33m=======> %s <=======\e[m\n" "$1"
}

# Use the install command to copy instead of cp and set permissions correctly.
# We need to do this because when we curl the git repo everything gets 755 which is no beuno
cp_safe () {
  install -m 644 "$1" "$2"
}

if [[ ! ($* == *--stage2*) ]] # If its not stage 2 its stage 1, hopefully..
then
  # Stage 1 initiated by just running ./setup.sh
  print_info "🚀🚀🚀 Alright.. sit back and enjoy the ride.. 🚀🚀🚀"
  print_info "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  print_info "Installing applications with brew cask..."
  brew install --cask google-chrome
  brew install --cask firefox
  brew install --cask 1password
  brew install --cask visual-studio-code
  brew install --cask postman
  brew install --cask dbeaver-community
  brew install --cask alfred
  brew install --cask rectangle
  brew install --cask slack
  brew install --cask beeper
  brew install --cask spotify

  print_info "Installing CLI tools..."
  brew install thefuck
  brew install autojump

  print_info "Setting up Dock"
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock orientation right
  killall Dock

  print_info "Setting up Terminal..."
  # Install oh-my-zsh
  # Note! We're sed-ing to remove `env zsh -l` from the oh-my-zsh start script so we can keep running..
  # Hopefully i can remove that one day..
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g')"

  zsh -c "./setup.sh --stage2"
  env zsh
else
  # Stage 2,
  # Setup zsh
  cp_safe ./config/doubleend.zsh-theme  ~/.oh-my-zsh/themes/
  cp_safe ./config/.zshrc ~/.zshrc
  cp_safe ./config/.vimrc ~/.vimrc

  # Add terminal themes and set the default
  theme=$(<config/MaterialTheme.xml)
  plutil -replace Window\ Settings.Material-Theme -xml "$theme" ~/Library/Preferences/com.apple.Terminal.plist
  theme=$(<config/Danger-Theme.xml)
  plutil -replace Window\ Settings.Danger-Theme -xml "$theme" ~/Library/Preferences/com.apple.Terminal.plist
  defaults write com.apple.Terminal "Default Window Settings" -string "Material-Theme"
  defaults write com.apple.Terminal "Startup Window Settings" -string "Material-Theme"
  defaults write com.apple.Terminal "NSWindow Frame TTWindow Material-Theme" -string "0 327 640 450 0 0 1280 777 "

  print_info "Installing node..."
  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"

  nvm install --lts
  nvm use --lts
  nvm alias default lts/*
  brew install yarn --without-node

  source ~/.zshrc

  print_info "Finishing touches..."
  mkdir -p ~/Documents/Projects

  code --install-extension Shan.code-settings-sync
  mkdir -p ~/Library/Application\ Support/Code/User/
  cp_safe ./config/syncLocalSettings.json ~/Library/Application\ Support/Code/User/syncLocalSettings.json

  print_info "PS: Remember to restart Terminal completely for your theme to take effect."
  print_info "🎉🎉🎉 All done!! 🎉🎉🎉"
  exit
fi
