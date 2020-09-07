# Simple git pair. Like "hitch" but simpler/less buggy for me.
# Also see prompt.sh.

getpair() { echo "`git config user.name` <`git config user.email`>"; }

alias pair='echo Committing as: `getpair`'
alias unpair="git config --remove-section user 2> /dev/null; echo Unpaired.; pair"

# Amend the last commit with the current pair (when you forget to set the pair until after committing.)
alias pair!='git commit --amend -C HEAD --author="`getpair`"; git show --format="Author: %an <%ae>" --quiet'

setpair() { git config user.pair "$1" && git config user.email "$2" && git config user.name "$3"; pair; }

# Add one of these for every pair. Each pair should be in alphabetical order by first name.
alias paira='setpair  AR+TS  devs+soma+tskogberg@auctionet.com  "Albert Ramstedt and Tomas Skogberg"'
alias pairh='setpair  HN+TS  devs+henrik+tskogberg@auctionet.com  "Henrik Nyh and Tomas Skogberg"'
alias pairj='setpair  JK+TS  devs+joakimk+tskogberg@auctionet.com   "Joakim Kolsjö and Tomas Skogberg"'
alias pairk='setpair  KP+TS  devs+lavinia+tskogberg@auctionet.com     "Kim Persson and Tomas Skogberg"'
alias pairp='setpair  PW+TS  devs+p-wall+tskogberg@auctionet.com  "Peter Wall and Tomas Skogberg"'
alias pairo='setpair  OJ+TS  devs+olleolleolle+tskogberg@auctionet.com  "Olle Jonsson and Tomas Skogberg"'
alias pairjk='setpair  JK+KP+TS  devs+joakimk+lavinia+tskogberg@auctionet.com   "Joakim Kolsjö, Kim Persson, and Tomas Skogberg"'
alias pairjp='setpair  JK+PW+TS  devs+joakimk+p-wall+tskogberg@auctionet.com   "Joakim Kolsjö, Peter Wall, and Tomas Skogberg"'
alias pairhk='setpair  HN+KP+TS  devs+henrik+lavinia+tskogberg@auctionet.com   "Henrik Nyh, Kim Persson, and Tomas Skogberg"'
alias pairhp='setpair  HN+PW+TS  devs+henrik+p-wall+tskogberg@auctionet.com   "Henrik Nyh and Peter Wall and Tomas Skogberg"'
alias pairho='setpair  HN+OJ+TS  devs+henrik+olleolleolle+tskogberg@auctionet.com   "Henrik Nyh and Olle Jonsson and Tomas Skogberg"'
alias pairmob='setpair MOB devs@auctionet.com "Mob"'
