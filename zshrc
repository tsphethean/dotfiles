# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
# export EDITOR=vim
# export EDITOR="/usr/bin/emacs"
export EDITOR="emacs"

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

#git support / git shortcuts
function search-history {
  git log --pretty=format:'%h was %an, %ar, message: %s' | grep $@ | less
}

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

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# keep prompt all the way left http://jonisalonen.com/2012/your-bash-prompt-needs-this/
export PS1="\[\033[G\]$PS1"

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=10000
export HISTCONTROL=erasedups

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

# REE / improved Ruby settings
export RUBY_HEAP_FREE_MIN=1024
export RUBY_HEAP_MIN_SLOTS=4000000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_GC_MALLOC_LIMIT=500000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1

# export RUBY_HEAP_MIN_SLOTS=1000000
# export RUBY_HEAP_FREE_MIN=500000
# export RUBY_HEAP_SLOTS_INCREMENT=1000000
# export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
# export RUBY_GC_MALLOC_LIMIT=100000000

export RUBYOPT="rubygems"

#java home
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

#andriod
export PATH=${PATH}:/Users/danmayer/projects/andriod/android-sdk-mac_86/tools
export PATH=${PATH}:/Users/danmayer/projects/andriod/android-sdk-mac_86/platform-tools

export PATH=/usr/local/bin/:${PATH}

#NPM
export PATH=/Users/danmayer/Developer/share/npm/bin/:${PATH}

alias mou="open /Applications/Mou.app"

# setup new gemset
# example usage: init_gemset mygemset
function initgemset()
{
    local  myresult=`ruby /Users/danmayer/projects/script_helpers/init_gemset.rb $1`
    eval "$myresult"
}

alias init_gemset='initgemset'

#pieces taken from https://github.com/myobie/dot-files/blob/master/.bash_profile
#titlebar update
directory_to_titlebar () {
  printf "\033]0;%s\007" `fancy_directory`
}

fancy_directory () {
    local pwd_length=42 # The maximum length we want (seems to fit nicely
                         # in a default length Terminal title bar).

    # Get the current working directory. We'll format it in $dir.
    local dir="$PWD"

    # Substitute a leading path that's in $HOME for "~"
    if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
dir="~${dir:${#HOME}}"
    fi
export WORK=/Volumes/Work
    # Substitute a leading path that's in $WORK for "w"
    if [[ "$WORK" == ${dir:0:${#WORK}} ]] ; then
dir="w${dir:${#WORK}}"
    fi

    # Append a trailing slash if it's not there already.
    if [[ ${dir:${#dir}-1} != "/" ]] ; then
dir="$dir"
    fi

    # Truncate if we're too long.
    # We preserve the leading '/' or '~/', and substitute
    # ellipses for some directories in the middle.
    if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]] ; then
local tilde=${BASH_REMATCH[1]}
        local directory=${BASH_REMATCH[2]}

        # At this point, $directory is the truncated end-section of the
        # path. We will now make it only contain full directory names
        # (e.g. "ibrary/Mail" -> "/Mail").
        if [[ "$directory" =~ [^/]*(.*) ]] ; then
directory=${BASH_REMATCH[1]}
        fi

        # Ellipsis
        dir="$tilde/...$directory"
    fi

    # Don't embed $dir directly in printf's first argument, because it's
    # possible it could contain printf escape sequences.
    # printf "\033]0;%s\007" "$dir"
    # printf "➙ \033]0;%s\007" "$dir"
    echo "$dir"
}

#bash title
if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" || "$TERM" == "xterm-256color" ]] ; then
  export PROMPT_COMMAND="directory_to_titlebar"
fi
#zshell title
precmd () {
  eval "directory_to_titlebar"
}

# extras that shouldn't be in the repo?
if [ -f ~/.bash_extras ]; then
  . ~/.bash_extras
fi

# via mojombo http://gist.github.com/180587
# ps aux grep without grep result
function psg {
  ps wwwaux | egrep "($1|%CPU)" | grep -v grep
}

# sweetness from tim pease:
p() {
  if [ -n "$1" ]; then
ps -O ppid -U $USER | grep -i "$1" | grep -v grep
  else
ps -O ppid -U $USER
  fi
}

pkill() {
  if [ -z "$1" ]; then
echo "Usage: pkill [process name]"
    return 1
  fi

local pid
  pid=$(p $1 | awk '{ print $1 }')

  if [ -n "$pid" ]; then
echo -n "Killing \"$1\" (process $pid)..."
    kill -9 $pid
    echo "done."
  else
echo "Process \"$1\" not found."
  fi
}

function open_branch { open http://code.livingsocial.net/$(whoami)/`basename \`pwd\``/tree/$(git symbolic-ref head| sed -e 's/.*\///g'); }
function open_branch_gh { open http://github.com/$(whoami)/`basename \`pwd\``/tree/$(git symbolic-ref head| sed -e 's/.*\///g'); }

#better cat with syntax highlights
alias cat="pygmentize -g"

ptests () {
	bundle exec rake test:prepare_parallel
	bundle exec rake test:no_rails
	echo "***** UNITS"
	date
	time bundle exec rake 'parallel:test[6, ^test/unit]'
	echo "***** FUNCTIONAL/INTEGRATION"
	date
	time bundle exec rake 'parallel:test[6, ^test/functional|^test/integ]'
	echo "***** ENDRUN"
	date
}

#better parallel tests
function runtests {
  ber test:prepare_parallel
  ber test:no_rails

  echo "***** UNITS"
  date
  time ber 'parallel:test[^test/unit]'

  echo "***** FUNCTIONAL/INTEGRATION"
  date
  time ber 'parallel:test[^test/functional|^test/integ]' 

  echo "***** ENDRUN"
  date
}

alias ber="bundle exec rake"

# finder

#this needs a fix for zhsell new terminal doesn't have correct dir
alias twd=new_terminal_working_directory
function new_terminal_working_directory() {
osascript <<END
tell application "Terminal"
tell application "System Events" to tell process "Terminal" to keystroke "t" using command down
do script "cd \"$(pwd)\"" in first window
end tell
END
}

alias cf=copy_finder_window_path
function copy_finder_window_path() {
osascript <<END
tell application "Finder"
set the_folder to (the target of the front window) as alias
set the_path to (get POSIX path of the_folder)
set the clipboard to the_path as text
end tell
END
}

alias gf="cf && cd \`pbpaste\` && clear && pwd"

alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

#load my cinderella profiles, for cinderella configs
[ -f ~/.cinderella.profile ] && source ~/.cinderella.profile

#new boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
CC=/usr/bin/gcc-4.2

export PATH="/Users/danmayer/Developer/Cellar/node/0.10.12/bin/node:$PATH"

export LDFLAGS="-L/opt/boxen/homebrew/opt/mysql55/lib"
export CPPFLAGS="-I/opt/boxen/homebrew/opt/mysql55/include"

RUBY_HEAP_MIN_SLOTS=2000000
RUBY_HEAP_SLOTS_INCREMENT=1600000
RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
RUBY_GC_MALLOC_LIMIT=9000000000
RUBY_HEAP_FREE_MIN=500000

export GREP_OPTIONS='--color=auto'
# export JAVA_HOME=/Library/Java/Home

#homebrew
PATH=/usr/local/sbin:$PATH