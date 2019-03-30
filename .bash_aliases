# git alias to manage dotfiles
alias dot='/usr/local/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'
__git_complete dot _git

# Symfony console app
alias console='bin/console'

# Use exa as listing tool instead of ls
alias ls='exa'
