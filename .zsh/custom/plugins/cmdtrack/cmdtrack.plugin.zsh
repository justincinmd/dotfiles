function cmdtrack_preexec() {
  cmdtrack track --workdir="`pwd`" --command="$1"
}

autoload -U add-zsh-hook
add-zsh-hook preexec cmdtrack_preexec
