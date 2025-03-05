#!/bin/zsh

unset PS1_NEWLINE_LOGIN
[ "sheldon" > /dev/null 2>&1 ] && eval "$(sheldon source)"

[ -s "$HOME/.cargo/env" ] && \.  "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ "fzf" > /dev/null 2>&1 ] && source <(fzf --zsh)
[ "zoxide" > /dev/null 2>&1 ] && eval "$(zoxide init zsh)"
