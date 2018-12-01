#!/bin/sh

# Pretty info throughout the process
print_info () {
  printf "\e[32m=======> $1 <=======\e[m\n"
}

print_warning () {
  printf "\e[33m=======> $1 <=======\e[m\n"
}

# Use the install command to copy instead of cp and set permissions correctly.
# We need to do this because when we curl the git repo everything gets 755 which is no beuno
cp_safe () {
  install -m 644 $1 $2
}

if [[ !($* == *--stage2*) ]] # If its not stage 2 its stage 1, hopefully..
then
  # Stage 1 initiated by just running ./setup.sh
  print_info "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  print_info "Installing applications with brew cask..."
  brew cask install google-chrome
  brew cask install visual-studio-code
  brew cask install alfred
  brew cask install shiftit
  brew cask install slack
  brew cask install spotify

  print_info "Installing CLI tools..."
  brew install thefuck
  brew install autojump

  print_info "Setting up Terminal..."
  # Install oh-my-zsh
  # Note! We're sed-ing to remove `env zsh -l` from the oh-my-zsh start script so we can keep running..
  # Hopefully i can remove that one day..
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g')"

  zsh -c "./test.sh --stage2"
  env zsh
else
  # Stage 2,
  # Setup zsh
  cp_safe ./config/doubleend.zsh-theme  ~/.oh-my-zsh/themes/
  print_warning "TODO: Figure out how to set .terminal theme programatically"
  # TODO: Figure out how to set .terminal theme programatically
  cp_safe ./config/.zshrc ~/.zshrc
  cp_safe ./config/.vimrc ~/.vimrc

  print_info "Installing node..."
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

  print_info "Finishing touches..."
  mkdir -p ~/Documents/Projects

  code --install-extension Shan.code-settings-sync
  mkdir -p ~/Library/Application\ Support/Code/User/
  cp_safe ./config/syncLocalSettings.json ~/Library/Application\ Support/Code/User/syncLocalSettings.json

  print_info "All done!"
  exit
fi