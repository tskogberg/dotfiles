# Simple git pair. Like "hitch" but simpler/less buggy for me.
# Also see prompt.sh.

getpair() { echo "`git config user.name` <`git config user.email`>"; }

alias pair='echo Committing as: `getpair`'
alias unpair="git config --remove-section user 2> /dev/null; echo Unpaired.; pair"

# Amend the last commit with the current pair (when you forget to set the pair until after committing.)
alias pair!='git commit --amend -C HEAD --author="`getpair`"; git show --format="Author: %an <%ae>" --quiet'

setpair() { git config user.pair "$1" && git config user.email "$2" && git config user.name "$3"; pair; }

# Add one of these for every pair. Each pair should be in alphabetical order by first name.
alias paira='setpair  AR+TS  all+albert+tomas@barsoom.se  "Albert Ramstedt and Tomas Skogberg"'
alias pairj='setpair  JK+TS  all+jocke+tomas@barsoom.se   "Joakim Kolsjö and Tomas Skogberg"'
alias pairk='setpair  KP+TS  all+kim+tomas@barsoom.se     "Kim Persson and Tomas Skogberg"'
alias pairh='setpair  HN+TS  all+henrik+tomas@barsoom.se  "Henrik Nyh and Tomas Skogberg"'
alias pairva='setpair  TS+VA  all+tomas+victor@barsoom.se  "Tomas Skogberg and Victor Arias"'
alias pairvk='setpair  TS+VK  all+tomas+victor@barsoom.se  "Tomas Skogberg and Victor Koronen"'
