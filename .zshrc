# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/dev
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# . ~/.local/bin/virtualenvwrapper.sh

# export GIT_BASEDIR=/media/fred/Storage/dev
# export PROJECTS=$GIT_BASEDIR
# . $GIT_BASEDIR/dotfiles/rcfile/standardrc.sh


# # nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# [ -r $NVM_DIR/bash_completion ] && . $NVM_DIR/bash_completion
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

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

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
