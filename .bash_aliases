alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Monitoring tool
alias top='htop'

# Git related alias
# alias for managing dotfiles in home directory using 'dot' as alias for git
alias dot='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
_xfunc git __git_complete dot _git

# Jekyll related alias
alias jek-dev='jekyll s --livereload --incremental'

# Youtube-dl related alias
alias youtube-dl='youtube-dl --external-downloader aria2c'

# PHP project related alias
# Symfony console alias
alias console='bin/console'
