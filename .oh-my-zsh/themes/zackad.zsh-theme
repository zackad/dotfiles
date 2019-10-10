# my bash prompt ported to zsh

PROMPT=$'%B%{$FG[014]%}[%D{%H:%M:%S}]%b%{$reset_color%} %B%{$FG[010]%}%n%{$FG[015]%}%b@%B%{$FG[012]%}%m%b$(git_prompt_info):%{$reset_color%} %{$FG[005]%}[%~]%{$reset_color%} $(bzr_prompt_info)
%{$FG_bold[black]%}%(!.#.$)%{$reset_color%} '

PROMPT2="%{$fg_blod[black]%}%_> %{$reset_color%}"

GIT_CB=""
ZSH_THEME_SCM_PROMPT_PREFIX=" %{$FG[008]%}("
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[014]%}*%{$FG[008]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
