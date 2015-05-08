# Colors
export COLOR_NC='\[\e[0m\]' # No Color
export COLOR_WHITE='\[\e[1;37m\]'
export COLOR_BLACK='\[\e[0;30m\]'
export COLOR_BLUE='\[\e[0;34m\]'
export COLOR_LIGHT_BLUE='\[\e[1;34m\]'
export COLOR_GREEN='\[\e[0;32m\]'
export COLOR_LIGHT_GREEN='\[\e[1;32m\]'
export COLOR_CYAN='\[\e[0;36m\]'
export COLOR_LIGHT_CYAN='\[\e[1;36m\]'
export COLOR_RED='\[\e[0;31m\]'
export COLOR_LIGHT_RED='\[\e[1;31m\]'
export COLOR_PURPLE='\[\e[0;35m\]'
export COLOR_LIGHT_PURPLE='\[\e[1;35m\]'
export COLOR_BROWN='\[\e[0;33m\]'
export COLOR_YELLOW='\[\e[1;33m\]'
export COLOR_GRAY='\[\e[0;30m\]'
export COLOR_LIGHT_GRAY='\[\e[0;37m\]'

PLAIN_COLOR=$COLOR_YELLOW

# Removing this for the time being, since it seems to be provided on most systems
# alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"

# PS1="${COLOR_WHITE}White${COLOR_BLACK}Black${COLOR_BLUE}Blue${COLOR_LIGHT_BLUE}Light Blue${COLOR_GREEN}Green${COLOR_LIGHT_GREEN}Light Green${COLOR_CYAN}Cyan${COLOR_LIGHT_CYAN}Light Cyan${COLOR_RED}Red${COLOR_LIGHT_RED}Light Red${COLOR_PURPLE}Purple${COLOR_LIGHT_PURPLE}Light Purple${COLOR_BROWN}Brown${COLOR_YELLOW}Yellow${COLOR_GRAY}Gray${COLOR_LIGHT_GRAY}Light Gray"
PS1="${COLOR_GREEN}\u${PLAIN_COLOR}@${COLOR_BROWN}\h${PLAIN_COLOR}:${COLOR_BLUE}\w ${COLOR_LIGHT_RED}\$(__git_ps1) ${PLAIN_COLOR}\$ ${COLOR_NC}"

if [ "$YELP_IN_SANDBOX" ]; then
    export PS1="$PS1(sandbox)\$ "

    # testify tab completion
    testify_tab_file=$HOME/bin/testify-bash-completion/testify.sh
    if [ -f $testify_tab_file ];
    then
        source $testify_tab_file ;
    fi
fi

testify() {
  if [ "$YELP_IN_SANDBOX" ]; then
    command testify "$@"
  else
    echo "You're not in a sandbox, dummy!"
    return 1
  fi
}

# Disable <Cr-S> and <CR-Q> for vim
stty start undef stop undef

# Add $HOME bin to PATH
PATH=$HOME/bin:$HOME/bin/vim/bin:$PATH

# RVM and Mac Path Changes
PATH=$PATH:/usr/local/sbin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Increase length of stored history
export HISTSIZE=50000
export HISTFILESIZE=500000
# Save history from all shells
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups
# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Import shard rc file
if [ -f ~/.sharedrc ]; then
  source ~/.sharedrc
fi

# From default ubuntu bashrc:

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

