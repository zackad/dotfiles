# Bash autocomplete
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# Bash aliases
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# bash PS1
if [ -f ~/.bash_function ]; then
. ~/.bash_function
fi
PS1="$(cyan)[\t] $(green)\u$(reset)@$(blue)\h$(gray)"'`__git_ps1`'
PS1="$PS1: $(cyan)\e[95m\e[2m[\w]$(reset)\n\\$ "
export PS1="$PS1"

# git from Homebrew
PATH=/usr/local/git/bin:$PATH

# GDAL path
PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH

# ls color
export CLICOLOR=1

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Homebrew PHP
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"

# Flutter SDK
export PATH="$PATH:/Users/zackad/.SDK/flutter/bin"

# Symfony console autocomplete
export PATH="$HOME/.composer/vendor/bin:$PATH"
eval "$(symfony-autocomplete)"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
