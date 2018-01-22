au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*,*.nginx if &ft == '' | setfiletype nginx | endif
