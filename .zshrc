fpath=($ZDOTDIR/completions $fpath)
# configurable
export PROJECTS="$HOME/dev"

ZSH_CACHE="$HOME/.zsh-cache"
if [ ! -d "$ZSH_CACHE" ]; then
  mkdir -p "$ZSH_CACHE"
fi

# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt fred

# Initialize completion
autoload -U compinit
compinit
# enable completion menu
zstyle ':completion:*' menu select

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
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUAL_ENV_DISABLE_PROMPT=1
. ~/.local/bin/virtualenvwrapper.sh


# ruby (rvm)
# export RVM_DIR="$HOME/.rvm"
# [ -s "$RVM_DIR/scripts/rvm" ] && . "$RVM_DIR/scripts/rvm"

# initialise fasd
if [ $commands[fasd] ]; then # check if fasd is installed
  fasd_cache="$ZSH_CACHE/fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache

  alias 2='fasd_cd -d'
  alias j='fasd_cd -d -i'
  alias o='fasd -a -e xdg-open'
  alias e='fasd -a -i -e vim'
fi

# Aliases
function up() {
  dst="../"
  if [ -n "$1" ]; then
    dst=`printf "%${1}s" | sed -e 's: :../:g'`
  fi
  cd $dst
}

alias x=exit
alias g=hub
alias "g+"="g add --all && g staged"
alias "g-"="g reset HEAD --"
alias s="g status || ls -t"
alias l="g ga"

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

# fancy cat
function colored_cat() {
  pygmentize -g -O style=monokai,linenos=1 $* | maybe-page.sh
}
alias c=colored_cat

# quick switching to projects
hash -d p="$PROJECTS"

function £() {
  fasd_cd -d $PROJECTS/$1
}

# bind keys that were broken for some reason
bindkey '^[[1~' beginning-of-line # Home
bindkey "^[[4~" end-of-line # End
bindkey "^[[3~" delete-char # Delete

bindkey "\C-k" kill-whole-line

# According to docs, this must come right at the end
source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh"
# bind up/down to search history with substring (replace default behaviour)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
