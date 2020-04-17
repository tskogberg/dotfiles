# Simple git pair. Like "hitch" but simpler/less buggy for me.
# Also see prompt.sh.

getpair() { echo "`git config user.name` <`git config user.email`>"; }

alias pair='echo Committing as: `getpair`'
alias unpair="git config --remove-section user 2> /dev/null; echo Unpaired.; pair"

# Amend the last commit with the current pair (when you forget to set the pair until after committing.)
alias pair!='git commit --amend -C HEAD --author="`getpair`"; git show --format="Author: %an <%ae>" --quiet'

setpair() { git config user.pair "$1" && git config user.email "$2" && git config user.name "$3"; pair; }

# Add one of these for every pair. Each pair should be in alphabetical order by first name.
alias paira='setpair  AR+TS  devs+albert+tomas@auctionet.com  "Albert Ramstedt and Tomas Skogberg"'
alias pairf='setpair  FH+TS  devs+fabian+tomas@auctionet.com  "Fabian Hoffmann and Tomas Skogberg"'
alias pairh='setpair  HN+TS  devs+henrik+tomas@auctionet.com  "Henrik Nyh and Tomas Skogberg"'
alias pairj='setpair  JK+TS  devs+jocke+tomas@auctionet.com   "Joakim Kolsjö and Tomas Skogberg"'
alias pairk='setpair  KP+TS  devs+kim+tomas@auctionet.com     "Kim Persson and Tomas Skogberg"'
alias pairp='setpair  PW+TS  devs+peter+tomas@auctionet.com  "Peter Wall and Tomas Skogberg"'
alias pairp='setpair  OJ+TS  devs+olle+tomas@auctionet.com  "Olle Jonsson and Tomas Skogberg"'
alias pairv='setpair  TS+VA  devs+tomas+victor@auctionet.com  "Tomas Skogberg and Victor Arias"'
alias pairvk='setpair  TS+VK  devs+tomas+victor@auctionet.com  "Tomas Skogberg and Victor Koronen"'
alias pairjl='setpair  JK+LF+TS  devs+jocke+lennart+tomas@auctionet.com   "Joakim Kolsjö, Lennart Fridén, and Tomas Skogberg"'
alias pairfk='setpair  FH+KP+TS  devs+fabian+kim+tomas@auctionet.com   "Fabian Hoffmann, Kim Persson, and Tomas Skogberg"'
alias pairjk='setpair  JK+KP+TS  devs+jocke+kim+tomas@auctionet.com   "Joakim Kolsjö, Kim Persson, and Tomas Skogberg"'
alias pairhk='setpair  HN+KP+TS  devs+henrik+kim+tomas@auctionet.com   "Henrik Nyh, Kim Persson, and Tomas Skogberg"'
alias pairhp='setpair  HN+PW+TS  devs+henrik+peter+tomas@auctionet.com   "Henrik Nyh and Peter Wall and Tomas Skogberg"'
alias pairho='setpair  HN+OJ+TS  devs+henrik+olle+tomas@auctionet.com   "Henrik Nyh and Olle Jonsson and Tomas Skogberg"'
alias pairmob='setpair MOB devs@auctionet.com "Mob"'
