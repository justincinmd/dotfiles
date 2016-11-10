function cmdtrack_preexec() {
  echo "Executing"
  echo "Entered $1"
  echo "Limited text $2"
  echo "Full text $3"
}

autoload -U add-zsh-hook
add-zsh-hook preexec cmdtrack_preexec
