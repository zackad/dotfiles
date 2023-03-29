# Environment variable
# ====================
# Setting locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

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
