# git alias to manage dotfiles
alias dot='/usr/local/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'
__git_complete dot _git

# Symfony console app
alias console='bin/console'

# youtube-dl extra argument
alias youtube-dl='/usr/local/bin/youtube-dl --external-downloader aria2c --external-downloader-args "-j 16 -s 16 -x 16 -k 2M"'
