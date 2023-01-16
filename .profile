# ==============================================================================
#                           Additional PATH
# ==============================================================================
# Local PATH on home directory
PATH="$HOME/.local/bin:$PATH"
# Symfony console autocomplete
PATH="$HOME/.composer/vendor/bin:$PATH"
# Golang binary
PATH="$HOME/.go/bin:$PATH"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
# End Nix

# ==============================================================================
# Misc
# ==============================================================================
# Load aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
# Setting locale
export LC_ALL="en_US.UTF-8"

# Prompt gpg passphrase on cli
export GPG_TTY=$TTY

# exit pager directly if enough space
export PAGER='less -FRX'

export EDITOR='vim'

# Load symfony-autocomplete
eval "$(symfony-autocomplete)"

# bun completions
[ -s "/Users/zackad/.bun/_bun" ] && source "/Users/zackad/.bun/_bun"

# Ignore php-cs-fixer environment error
export PHP_CS_FIXER_IGNORE_ENV=1
