# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt fred

# Initialize completion
autoload -U compinit
compinit

# Add paths
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export EDITOR=vi
# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back.
set -o emacs

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Aliases
function lack() {
    # The +k clears the screen (it tries to scroll up but there's nowhere to
    # go)
    ack --group --color $* | less -r +k
}
function mcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ } # stolen from @topfunky

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# [ -r $NVM_DIR/bash_completion ] && . $NVM_DIR/bash_completion


# python (virtualenvwrapper)
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
. ~/.local/bin/virtualenvwrapper.sh


# Aliases
function up() {
  dst="../"
  if [ -n "$1" ]; then
    dst=`printf "%${1}s" | sed -e 's: :../:g'`
  fi
  cd $dst
}

alias x=exit
alias g=git
alias "g+"="git add --all && git staged"
alias "g-"="git reset HEAD --"
alias s="git status || ls -t"
alias l="git ga"

alias h=heroku
alias y=yarn
alias "y+"="yarn add"
alias yd="yarn add --dev"

# ls: make "other-writable" directories bold light blue on dark grey
export LS_COLORS="ow=01;94;100"
alias ls="ls -l --color=auto --group-directories-first"

function keepdoing() {
  watchmedo shell-command --patterns="*.py;*.sh;*file" --ignore-directories --recursive --drop --command="$@"
}
alias kd=keepdoing

function grepp() {
  clear && ag --group -A 2 --smart-case --pager="maybe-page.sh" $*
}

alias "?"=grepp
