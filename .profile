# Environment variable
# ====================
# Setting locale
export LC_ALL="C.UTF-8"
export LANG="C"

# Prompt gpg passphrase on cli
export GPG_TTY=$TTY

# exit pager directly if enough space
export PAGER='less -FRX'

export EDITOR='vim'

# PATH
# ====
# Local PATH on home directory
PATH="${PATH}:$HOME/.local/bin"
# Symfony console autocomplete
PATH="${PATH}:$HOME/.composer/vendor/bin"
export PATH="${PATH}"

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# home-manager session
if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
fi
# End Nix

# Misc
# ====
# Load aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi
