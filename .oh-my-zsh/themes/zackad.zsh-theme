# my bash prompt ported to zsh

PROMPT=$'%B%{$FG[014]%}[%D{%H:%M:%S}]%b%{$reset_color%} %B%{$FG[010]%}%n%{$FG[015]%}%b@%B%{$FG[012]%}%m%b$(git_prompt_info):%{$reset_color%} %{$FG[005]%}[%~]%{$reset_color%} $(bzr_prompt_info)
%{$FG_bold[black]%}%(!.#.$)%{$reset_color%} '

PROMPT2="%{$fg_blod[black]%}%_> %{$reset_color%}"

GIT_CB=""
TIMER_FORMAT="[%d]"
TIMER_THRESSHOLD="5"
ZSH_THEME_SCM_PROMPT_PREFIX=" %{$FG[008]%}("
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[014]%}*%{$FG[008]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Following code is copied from timer plugin of oh-my-zsh with some feature added
# ==============================================================================
# Start of Timer Plugin
# ==============================================================================
__timer_current_time() {
  perl -MTime::HiRes=time -e'print time'
}

__timer_format_duration() {
  local mins=$(printf '%.0f' $(($1 / 60)))
  local secs=$(printf "%.${TIMER_PRECISION:-1}f" $(($1 - 60 * mins)))
  local duration_str=$(echo "${mins}m${secs}s")
  local format="${TIMER_FORMAT:-/%d}"
  echo "${format//\%d/${duration_str#0m}}"
}

__timer_save_time_preexec() {
  __timer_cmd_start_time=$(__timer_current_time)
}

__timer_display_timer_precmd() {
  if [ -n "${__timer_cmd_start_time}" ]; then
    local cmd_end_time=$(__timer_current_time)
    local tdiff=$((cmd_end_time - __timer_cmd_start_time))

    # Print timer only if larger than thresshold (default 3 seconds)
    if [ 1 -eq "$(echo "${tdiff} <= ${TIMER_THRESSHOLD:-3}" | bc)" ];then
      return
    fi

    unset __timer_cmd_start_time
    local tdiffstr=$(__timer_format_duration ${tdiff})
    local cols=$((COLUMNS - ${#tdiffstr} - 1))
    echo -e "\033[1A\033[${cols}C ${tdiffstr}"
  fi
}

preexec_functions+=(__timer_save_time_preexec)
precmd_functions+=(__timer_display_timer_precmd)

# ==============================================================================
# End of Timer Plugin
# ==============================================================================
