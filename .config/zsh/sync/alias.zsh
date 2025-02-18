#  ╭──────────────────────────────────────────────────────────╮
#  │               .zshrc編集簡略化用エイリアス               │
#  ╰──────────────────────────────────────────────────────────╯
alias reload='source ~/dotfiles/.config/zsh/.zshrc; clear'
alias zshconf='vim ~/dotfiles/.config/zsh/'

#  ╭──────────────────────────────────────────────────────────╮
#  │           init.vim(.vimrc)編集簡略化用エイリj            │
#  ╰──────────────────────────────────────────────────────────╯
alias vimconf='vim ~/dotfiles/.config/nvim'

#  ╭──────────────────────────────────────────────────────────╮
#  │                 基本コマンドのエイリアス                 │
#  ╰──────────────────────────────────────────────────────────╯
if type "lsd" > /dev/null 2>&1; then 
  alias ls='lsd'
  alias ll='lsd -alF'
  alias la='lsd -A'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias e='emacs'
alias c='code'
