# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/zackad/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose python-autoload-venv)

source $ZSH/oh-my-zsh.sh

# User configuration

# Setting locale
export LC_ALL="en_US.UTF-8"

# Prompt gpg passphrase on cli
export GPG_TTY=$TTY

# exit pager directly if enough space
export PAGER='less -FRX'

# ==============================================================================
#                           Additional PATH
# ==============================================================================

# Local PATH on home directory
PATH="/usr/local/sbin:$PATH"
PATH="$HOME/.local/bin:$PATH"

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"

# GDAL library from qgis
PATH="$PATH:/Applications/QGIS.app/Contents/MacOS/bin"

#PHPBrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Symfony console autocomplete
PATH="$HOME/.composer/vendor/bin:$PATH"

# Golang binary
PATH="$HOME/.go/bin:$PATH"

export PATH

# ==============================================================================
#                               Aliases
# ==============================================================================

# git alias to manage dotfiles
alias dot='/usr/local/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'

# Symfony console app
alias console='bin/console'

# Use exa as listing tool instead of ls
alias ls='exa'

# ==============================================================================
# Misc
# ==============================================================================

# zsh completion
fpath=($(brew --prefix)/share/zsh-completions $fpath)
for f (/usr/local/share/zsh/site-functions/*(N.)) . $f

# Initializing script and setup
ulimit -S -n 8192

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load symfony-autocomplete
eval "$(symfony-autocomplete)"
