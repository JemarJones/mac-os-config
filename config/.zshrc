
### Beginning of Jemar's customs .zshrc config ###

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="doubleend"

plugins=(
  git
  autojump
)

# User configuration

source $ZSH/oh-my-zsh.sh
eval $(thefuck --alias oops)
eval $(thefuck --alias fuck)
# Autojump config
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
alias incognito="echo 'Entering incognito mode now. Command history will not be recorded.'; unset HISTFILE; echo 'tell application \"Terminal\" to set current settings of first window to settings set \"Danger-Theme\"' | osascript"

#Path
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
