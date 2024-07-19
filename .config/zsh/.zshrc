#!/bin/zsh

unset PS1_NEWLINE_LOGIN
eval "$(sheldon source)"

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/katsu/.bun/_bun" ] && source "/home/katsu/.bun/_bun"
