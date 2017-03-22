export PATH="$(brew --prefix git)/bin:$PATH" # go ahead and install git via brew beforehand
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

