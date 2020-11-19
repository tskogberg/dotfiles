# Management
alias dots="cd ~/.dotfiles && vim ."
alias reload='source ~/.zshrc && echo "sourced ~/.zshrc"'
alias redot='cd ~/.dotfiles && gpp && rake install; cd -'
alias udsub='cd ~/.dotfiles && git submodule update --recursive --remote'

alias hosts='sudo vim /etc/hosts'
alias vrb='vim -c "setf ruby"'

# http://www.hogbaysoftware.com/products/writeroom
alias text='cd ~/Dropbox/WhiteRoom && vim'

# Shell
alias la='ls -alh'
alias cdd='cd -'  # back to last directory
alias pg='ps aux | grep '
alias tf='tail -F -n200'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ssh-restart='eval "$(ssh-agent)" && ssh-add'

# Portable ls with colors
if ls --color -d . >/dev/null 2>&1; then
  alias ls='ls --color=auto'  # Linux
elif ls -G -d . >/dev/null 2>&1; then
  alias ls='ls -G'  # BSD/OS X
fi

# I always forget the common options.
alias rsync\?="echo 'rsync -az --progress server:/path/ path (Slashes are significant.)'"

# Ruby on Rails
alias sc="[ -f script/console ] && script/console || bundle exec rails console"
alias sdb="[ -f script/dbconsole ] && script/console --include-password || bundle exec rails dbconsole --include-password"
alias ss="[ -f script/server ] && script/server || rails server"
alias mig="[ -f Rakefile ] && rake db:migrate && [ -f Gemfile ] && grep -q 'parallel' Gemfile"
# The bare essentials, for slower machines like MacBook Airs.
alias f="bundle exec foreman start -f=Procfile"
# Everything, when we need it, or on faster machines.
alias ff="bundle exec foreman start"

alias be="bundle exec"

# Tests
alias rsua="bundle exec rake spec:unit:all"
alias rsp="rake testbot:spec"

# Git
alias g="git"
alias ga="git add"
alias gl="git pull --rebase"
alias gs="git status"
alias gst="gs"
alias gw="git show"
alias gw\^="git show HEAD\^"
alias gw\^\^="git show HEAD\^\^"
alias gd="git diff-index HEAD -p --color | less"  # What's changed? Both staged and unstaged.
alias gdo="git diff --cached"  # What's changed? Only staged (added) changes.
# for gco ("git commit only") and gca ("git commit all"), see functions.sh.
alias gcaf="git add --all && git commit --no-verify -m"
alias gcac="gca Cleanup"
alias gcoc="gco Cleanup"
alias gcab="gca Blankspace"
alias emptycommit="git commit -m 'Empty commit' --allow-empty"
alias gp="git push"
alias gpp='git pull --rebase && git push'
alias gppp="git push -u"  # Can't pull because you forgot to track? Run this.
alias gps='(git stash --include-untracked | grep -v "No local changes to save") && gpp && git stash pop || echo "Fail!"'
alias go="git checkout"
alias gb="git checkout -b"
alias got="git checkout -"
alias gom="git checkout master"
alias gr="git branch -d"
alias grr="git branch -D"
alias gcp="git cherry-pick"
alias gam="git commit --amend"
alias gamm="git add --all && git commit --amend -C HEAD"
alias gba="git rebase --abort"
alias gbc="git add -A && git rebase --continue"
alias gbm="git fetch origin master && git rebase origin/master"

# Heroku
alias h="heroku"
alias hp="git push heroku"
alias hmig="heroku run rake db:migrate"
alias ho="heroku open"
alias hc="heroku run console"
alias hsc="heroku run console -r production"  # Make Henrik happy
alias hlog="heroku logs -t"

# tmux
tn() { if [ $1 ]; then tmux new -s $1; else tmux new -s $(basename $PWD | tr . _); fi }
ta() { if [ $1 ]; then tmux attach -t $1; else tmux attach; fi }
alias tl="tmux ls"
# With tmux mouse mode on, just select text in a pane to copy.
# Then run tcopy to put it in the OS X clipboard (assuming reattach-to-user-namespace).
alias tcopy="tmux show-buffer | pbcopy"

# Servers
alias rst="touch tmp/restart.txt && echo touched tmp/restart.txt"  # Pow

# Work

kop() { if [ $1 ]; then lsof -n -i:$1 | grep LISTEN | awk '{ print $2 }' | uniq | xargs kill -9; else cat << EOF
Kills all processes on a portnumber

Usage: kop [port_number]
EOF
; fi }

udgems() {
  git pull
  dev
  bundle update
  git status | grep "not staged" &>/dev/null
  if [ $? -eq 0 ]; then
    if [ -d spec ]; then
      bundle exec rake || return
      bundle exec rake spec || return
    fi

    git commit -a -m "Update gems"
    git show
    echo "Amend to the commit message if there in any big changes and dont forget to run dev bundle!"
  else
    echo "Nothing to update!"
  fi

  if [ $1 ]; then
    echo "Outdated:" `bundle outdated|grep '* '|wc -l`
  fi

  dev stop
}

alias mobstation="ps ax|grep ssh|grep 9933|grep localhost|awk '{ print \$1 }'|xargs kill; ssh mob -L 9933:localhost:5900 -nNT 2> /dev/null & open vnc://localhost:9933"

# Other
alias v="vagrant"
loop_me() {
  while true; do
    eval $1;
    sleep ${2:=1};
  done
}

# Restart ntp (sync clock)
alias synctime="sudo service ntp stop && sudo ntpd -gq && sudo service ntp start"
