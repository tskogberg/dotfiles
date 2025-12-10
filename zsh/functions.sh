# OS X only:
# "o file.txt" = open file in default app.
# "o http://example.com" = open URL in default browser.
# "o" = open pwd in Finder.

function o {
  open "${@:-'.'}"
}


# "git commit only"
# Commits only what's in the index (what's been "git add"ed).
# When given an argument, uses that for a message.
# With no argument, opens an editor that also shows the diff (-v).

unalias gco 2>/dev/null  # ohmyzsh might define it
function gco {
  if [ -z "$1" ]; then
    git commit -v
  else
    git commit -m "$1"
  fi
}


# "git commit all"
# Commits all changes, deletions and additions.
# When given an argument, uses that for a message.
# With no argument, opens an editor that also shows the diff (-v).

unalias gca 2>/dev/null  # ohmyzsh might define it
function gca {
  git add --all && gco "$1"
}


# cd gem
#
#     henrik@Nyx ~$ cdgem thor
#     henrik@Nyx ~/.rvm/gems/ree-1.8.7-2010.02/gems/thor-0.14.6$

function cdgem {
  cd `rvm gemdir`/gems; cd `ls|grep $1|sort|tail -1`
}


# Print working file.
#
#     henrik@Henrik ~/.dotfiles[master]$ pwf ackrc
#     /Users/henrik/.dotfiles/ackrc

function pwf {
  echo "$PWD/$1"
}


# Create directory and cd to it.
#
#     henrik@Nyx /tmp$ mcd foo/bar/baz
#     henrik@Nyx /tmp/foo/bar/baz$

function mcd {
  mkdir -p "$1" && cd "$1"
}


# SSH to the given machine and add your id_rsa.pub or id_dsa.pub to authorized_keys.
#
#     henrik@Nyx ~$ sshkey hyper
#     Password:
#     sshkey done.

function sshkey {
  ssh $1 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_?sa.pub  # '?sa' is a glob, not a typo!
  echo "sshkey done."
}

# Connect to a kubernetes pod and attach to the Erlang node
ksh ()
{
    app=$1;
    pod=$(kubectl get pods -l app=$app -o=jsonpath='{.items[0].metadata.name}' 2>/dev/null);
    result=$?;
    if [ $result -ne 0 ]; then
        echo "could not get pods for $app";
        return $result;
    fi;
    kubectl exec -it $pod -- sh
}
# tmux

tn() {
  if [[ "$1" ]]; then
    tmux new -s "$1";
  else
    tmux new -s "$(basename "$PWD" | tr . _)";
  fi
}

ta() {
  currentTmuxSessions=$(tl | cut -d: -f1);
  currentBasename="$(basename "$PWD" | tr . _)";

  if [[ "$1" ]]; then
    tmux attach -t "$1";
  elif (($currentTmuxSessions[(Ie)$currentBasename])); then
    tmux attach -t $currentBasename;
  else
    tmux attach
  fi
}

tna() {
  tmux start-server

  cd /projects || exit
  for project in */; do
    cd "$project" || exit
    tmux new-session -d -s "$project"
    cd ..
  done

  ta
}

# Others

kop() {
  if [ "$1" ]; then
    lsof -n -i:"$1" | grep LISTEN | awk '{ print $2 }' | uniq | xargs kill -9;
  else
    printf "Kills all processes on a portnumber\n\nUsage: kop [port_number]\n";
  fi
}

loop_me() {
  while true; do
    eval "$1";
    sleep "${2:=1}";
  done
}

ollama_update() {
  ollama list | awk 'NR>1 {print $1}' | while read package; do
    echo "Updating $package..."
    ollama pull "$package"
  done
}
