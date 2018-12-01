export PATH="$(brew --prefix git)/bin:$PATH"
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="doubleend"

plugins=(git)

# User configuration

source $ZSH/oh-my-zsh.sh
eval $(thefuck --alias oops)
# Autojump config
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

#Path
export PATH="$(brew --prefix)/bin:$PATH" # go ahead and install git via brew beforehand
export PATH="$(yarn global bin):$PATH" # this makes yarn global installs work
export PATH=~/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
