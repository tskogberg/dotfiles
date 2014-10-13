ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}*"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function __rvm_prompt {
  if hash rvm-prompt 2>&- ; then
    echo " `rvm-prompt i v g s`"
  fi
}

function __git_prompt {
  GIT_PS1_SHOWDIRTYSTATE=1
  [ `git config user.pair` ] && GIT_PS1_PAIR=" `git config user.pair`"
  echo "$GIT_PS1_PAIR$(git_prompt_info)" | sed 's/ \([+*]\{1,\}\)$/\1/'
}

# Only show username@server over SSH.
function __name_and_server {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "`whoami`@`hostname -s` "
  fi
}

PROMPT="%{$FG[011]%}\$(__name_and_server)%{$FG[003]%}%~%{$FG[002]%}\$(__rvm_prompt)%{$FG[002]%}\$(__git_prompt)%{$reset_color%} %% "
