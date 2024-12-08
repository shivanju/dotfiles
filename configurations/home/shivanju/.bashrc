#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bash completion
if [ -f /etc/bash_completion ]; then
    /etc/bash_completion
fi

# fzf keybindings and completion
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash


#-----------------------------#
#         LOOK & FEEL         #
#-----------------------------#
#Color codes
#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37
CYAN='\033[0;36m'
DGRAY='\033[1;30m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
BLACK='\033[0;30m'
NC='\033[0m' # No Color

# Custom prompt config
export PS1="${CYAN}\u${NC}@${GREEN}\h${NC}${YELLOW}\w${NC}\$\n$"


#-----------------------------#
#       SHELL - HISTORY       #
#-----------------------------#
# Eternal bash history.
# Undocumented feature which sets the size to "unlimited".
export HISTFILESIZE=
export HISTSIZE=

# Change the file location because certain bash sessions truncate .bash_history
# file upon close.
export HISTFILE=~/.bash_eternal_history

# Append history from other parallel bash sessions instead of overwriting
shopt -s histappend

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups


#-----------------------------#
#          ALIASES            #
#-----------------------------#
alias ls="ls --color=auto"
alias pacin="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacup="sudo pacman -Syu"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
