#!/usr/bin/env sh
#
# This is the installer for macOS system that will install
# dotfiles repository into home directory and enable versioning
# using git and add an alias dot to track the change.

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install git
brew install git

# Clone Repository with "macos-branch"
git clone --bare https://github.com/zackad/dotfiles $HOME/.dot
git --git-dir=$HOME/.dot/ --work-tree=$HOME checkout macos-home
git --git-dir=$HOME/.dot/ --work-tree=$HOME config --local status.showUntrackedFiles no
source $HOME/.bash_profile

# Install php related tools
brew install php@7.2 composer

# Install nodejs related tools

# Install other tools
brew install aria2 bash-completion youtube-dl
