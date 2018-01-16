# Set UTF-8 as default
export LANG=sv_SE.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="headie"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler git gem headie)

# This will fix completion warning: https://github.com/robbyrussell/oh-my-zsh/issues/6461
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

# Custom plugins/setup
for file in ~/.dotfiles/zsh/*.sh; do
  source "$file"
done

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Add RVM to PATH for scripting
export PATH=$HOME/.rvm/bin:$PATH

# Load bs env
[[ -s "$HOME/.bs/profile" ]] && source "$HOME/.bs/profile"

# Load .profile, VMs need it
[[ -s ~/.profile ]] && source ~/.profile

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Store ssh password in keychain. This will stop git from asking for the password.
[[ $OSTYPE =~ "darwin" ]] && ssh-add -K

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

