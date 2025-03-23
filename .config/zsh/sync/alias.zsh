#  ╭──────────────────────────────────────────────────────────╮
#  │               .zshrc編集簡略化用エイリアス               │
#  ╰──────────────────────────────────────────────────────────╯
alias reload='source ~/dotfiles/.config/zsh/.zshrc; clear'
alias zshconf='vim ~/dotfiles/.config/zsh/'

#  ╭──────────────────────────────────────────────────────────╮
#  │           init.vim(.vimrc)編集簡略化用エイリアス         │
#  ╰──────────────────────────────────────────────────────────╯
alias vimconf='vim ~/dotfiles/.config/nvim'

#  ╭──────────────────────────────────────────────────────────╮
#  │            hyprlandの設定編集簡略化用エイリアス          │
#  ╰──────────────────────────────────────────────────────────╯
alias hconf='vim ~/dotfiles/.config/hypr'

#  ╭──────────────────────────────────────────────────────────╮
#  │                 基本コマンドのエイリアス                 │
#  ╰──────────────────────────────────────────────────────────╯
if type "lsd" > /dev/null 2>&1; then 
  alias ls='lsd'
  alias ll='lsd -alF'
  alias la='lsd -A'
  alias tree='ls --tree'
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias e="emacsclient -c -a 'emacs'"
alias c='code'

#  ╭──────────────────────────────────────────────────────────╮
#  │                   yaziで使用する関数                     │
#  ╰──────────────────────────────────────────────────────────╯
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
