# Setting locale
export LC_ALL="C.UTF-8"
export LANG="C"

# Prompt gpg passphrase on cli
export GPG_TTY="$TTY"

# Add directories into PATH
# Jetbrains Toolbox App
PATH="${PATH}:${HOME}/Applications/JetBrains/Toolbox/scripts"
PATH="${PATH}:${HOME}/.local/share/JetBrains/Toolbox/scripts"
# Bun (All In One javascript runtime)
PATH="${PATH}:${HOME}/.bun/bin"
# Symfony cli
PATH="${PATH}:${HOME}/.symfony/bin"
# Composer binary
PATH="${PATH}:${HOME}/.config/composer/vendor/bin"
# phpenv
PATH="${PATH}:${HOME}/.phpenv/bin"

export PATH="${PATH}"

# Ignore php-cs-fixer incompatibility error
export PHP_CS_FIXER_IGNORE_ENV=1

# Default editor
export EDITOR=vim

# Load nix profile
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh; 
fi
