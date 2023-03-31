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
#  │               ranger起動簡略化用エイリアス               │
#  ╰──────────────────────────────────────────────────────────╯
alias rng='ranger'
#  ╭──────────────────────────────────────────────────────────╮
#  │         rc.conf(ranger)の設定簡略化用エイリアス          │
#  ╰──────────────────────────────────────────────────────────╯
alias rngconf='vim ~/dotfiles/.config/ranger/rc.conf'

#  ╭──────────────────────────────────────────────────────────╮
#  │              qtileの設定簡略化用エイリアス               │
#  ╰──────────────────────────────────────────────────────────╯
alias qconf='vim ~/dotfiles/.config/qtile/'

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
alias apep='autopep8 --in-place --aggressive --aggressive'
#alias xmind='~/xmind/xmind.sh &'
alias e='emacs'

#  ╭──────────────────────────────────────────────────────────╮
#  │         npm startで起動するブラウザを制御したい          │
#  ╰──────────────────────────────────────────────────────────╯
# term_emu_name="$(basename "/"$(ps -o cmd -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/ .*$//'))"
# alias npm="start_npm $term_emu_name"

#  ╭──────────────────────────────────────────────────────────╮
#  │                         windows                          │
#  │         chromeとdeeplにエイリアスでアクセスする          │
#  ╰──────────────────────────────────────────────────────────╯
if [ ! -e "/mnt/c/'Program Files'/Google/Chrome/Application" ]; then
    alias c="/mnt/c/'Program Files'/Google/Chrome/Application/chrome.exe"
    alias deepl="/mnt/c/'Program Files'/Google/Chrome/Application/chrome.exe https://www.deepl.com/ja/translator"
fi

#  ╭──────────────────────────────────────────────────────────╮
#  │                         javafx                           │
#  ╰──────────────────────────────────────────────────────────╯
alias javafxc='javac --module-path /usr/lib/jvm/java-19-openjdk/lib/javafx --add-modules javafx.controls,javafx.fxml,javafx.media'
alias javafx='java --module-path   /usr/lib/jvm/java-19-openjdk/lib/javafx --add-modules javafx.controls,javafx.fxml,javafx.media'
