function cmdtrack_preexec() {
  (nohup cmdtrack track --workdir="`pwd`" --command="$1" &) > /dev/null 2>&1
}

autoload -U add-zsh-hook
add-zsh-hook preexec cmdtrack_preexec
