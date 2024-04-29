# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
plugins=(git docker python-autoload-venv zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export GPG_TTY=$TTY

PATH="${PATH}:${HOME}/.config/composer/vendor/bin"
export PATH="${PATH}:${HOME}/.local/bin"

# ==============================================================================
#                               Aliases
# ==============================================================================

alias ls='lsd'
alias gzip='pigz'

# git alias to manage dotfiles
alias got='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias nit='git --git-dir=$HOME/.nixos/ --work-tree=/etc/nixos'

# Symfony console app
alias console='bin/console'

alias less='less -S'
alias cat='bat'

# ==============================================================================
#                               Misc
# ==============================================================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh completion
fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

# Hook for direnv
eval "$(direnv hook zsh)"
