# Git

    #view full contents of file from specific version
    git show {hash}:path/to/file


# Dev environment needed improvements

* fix the 80 char break for html .erb it is far to annoying with our codes html
* fix the 80 char break on txt files
* showoff.io play with pow / pow proxy better / showoff restarter
* indention in emacs update command cmd-] to use spaces and jump 2 not 4


# Emacs commands I forget all the time

    C  (windows: start, mac: )
    M (windows: alt, mac: alt/option)
    cmd (windows: start, mac: command)

    cntl-g to quit current sub-buffer input line/function
    M-. #jump to tags under cursor
    M-. #goes to the method under the cur­sor, in the same win­dow. First time it asks for the TAGS file.
    C-4 . #goes to the method under the cur­sor. Opens a new win­dow. First time it asks for the TAGS file.
    M-, #loops to the next selection.
    C-u M-. #Find the next definition for the last tag
    M-* #Pop back to where you previously invoked "M-."
    
    #http://www.runtime-era.com/2012/05/exuberant-ctags-in-osx-107.html   
    brew install ctags-exuberant
    #generate tags for ruby project (run in root of project)
    ctags -f TAGS --extra=-f --languages=-javascript --exclude=.git --exclude=log -e -R . $(rvm gemdir)/gems/
    #http://stackoverflow.com/questions/10120720/generating-emacs-tags-file-for-a-ruby-on-rails-project
    #http://mattbriggs.net/blog/2012/03/18/awesome-emacs-plugins-ctags/


    #mostly these are from textmate.el
    cmd-l #jump to line number
    cmd-ctrl-t #textmate open file
    shift-cmd-t #jump to method

    #####indenting
    ## http://www.emacswiki.org/emacs/IndentingText
    C-x TAB #indent region
    C-u -3 C-x TAB #unindent region 3 places
    cmd-] #  'textmate-shift-right)
    cmd-[ # 'textmate-shift-left)

    ####vcs-mode
    C-x v = #git diff
    C-z v u #discard changes since last checkin
    C-x v l #view git log
    (possibly get Magit mode?)

    ####Shell commands
    M-x shell-command-on-region wc # word count on emacs region
    M-x shell # get a shell
    (possibly upgrade to eshell)
    cssh mode to run the same command on many machines and view the
    results collection

    ####ELPA (package manager)
    use this to install additional modes

    ####Emacs blog planetemacsen, http://planet.emacsen.org/

# Todos

    * cmd line command to open / run Mou with a file
    * finish porting emacs configs to my dot files project
    * use githooks to autoupdate my etags or possible guard etags gem
