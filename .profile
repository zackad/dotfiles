# Setting locale
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Prompt gpg passphrase on cli
export GPG_TTY="$TTY"

# Add directories into PATH
# Jetbrains Toolbox App
PATH="${PATH}:${HOME}/Applications/JetBrains/Toolbox/scripts"
PATH="${PATH}:${HOME}/.local/share/JetBrains/Toolbox/scripts"
# Composer binary
PATH="${PATH}:${HOME}/.config/composer/vendor/bin"
# phpenv
PATH="${PATH}:${HOME}/.phpenv/bin"

export PATH="${PATH}"

# Default editor
export EDITOR=vim

# Load nix profile
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh; 
fi
