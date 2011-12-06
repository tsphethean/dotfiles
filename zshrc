# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
# export EDITOR=vim
export EDITOR="/usr/bin/emacs"

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096

# look for ey config in project dirs
export EYRC=./.eyrc

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

# History: don't store duplicates
export HISTCONTROL=erasedups

# REE
export RUBY_HEAP_FREE_MIN=1024
export RUBY_HEAP_MIN_SLOTS=4000000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_GC_MALLOC_LIMIT=500000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1

# extras that shouldn't be in the repo?
if [ -f ~/.bash_extras ]; then
  . ~/.bash_extras
fi

export RUBYOPT=rubygems

#java home
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

#andriod
export PATH=${PATH}:/Users/danmayer/projects/andriod/android-sdk-mac_86/tools
export PATH=${PATH}:/Users/danmayer/projects/andriod/android-sdk-mac_86/platform-tools

# setup new gemset
# example usage: init_gemset mygemset
function initgemset()
{
    local  myresult=`ruby /Users/danmayer/projects/script_helpers/init_gemset.rb $1`
    eval "$myresult"
}

alias init_gemset='initgemset'

#load my cinderella profiles, for cinderella configs
source ~/.cinderella.profile

