#!/bin/zsh

# 
# ~/.zshrc
#
#

# ==============================================================================
# 
# history補完(C-r)ができなくなった時 
# 
# ==============================================================================

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# ==============================================================================
#
# 基本設定
#
# ==============================================================================

# 色をつけられるようにします。
autoload -Uz colors
colors

# ==============================================================================
# 
# 環境変数
# 
# ==============================================================================

# デフォルトで使用するエディタを設定します。
export EDITOR=vim

# 言語の設定を行います。
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

# ubuntuにて初回のみ以下を実行して日本語ディレクトリを英語名に
# LANG=C xdg-user-dirs-gtk-update

# 保管リストが多い時に尋ねる数です。
#  -1 : 訪ねません。
#   0 : 窓からあふれる場合は訪ねます。
export LISTMAX=0

# pyenvの環境変数
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
# pipenvの環境変数
export PIPENV_VENV_IN_PROJECT=1
# rangerでデフォルトのrc.confを読み込むかどうか
export RANGER_LOAD_DEFAULT_RC=FALSE

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
# ==============================================================================
# 
# プラグイン読み込み
# 
# ==============================================================================

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░  The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# 入力途中に候補をうっすら表示
zinit light "zsh-users/zsh-autosuggestions"

# fzf 本体（連携前提のパーツ）
zinit light "junegunn/fzf-bin"
zinit light "junegunn/fzf"


# fzf でよく使う関数の詰め合わせ
zinit light "mollifier/anyframe"

# ディレクトリ移動を高速化（fzf であいまい検索）
zinit light "b4b4r07/enhancd"

# ==============================================================================
# 
# エイリアス, コマンド
# 
# ==============================================================================

# C-sで画面が止まることを防止する。
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

# 保管される前にオリジナルのコマンドまで展開してチェックします。
setopt complete_aliases

# .zshrc編集簡略化用エイリアス 
alias reload='source ~/dotfiles/.zshrc && zplug load –-verbose ; clear'
alias zshconf='vim ~/dotfiles/.zshrc'

# init.vim(.vimrc)編集簡略化用エイリj
alias vimconf='vim ~/dotfiles/.config/nvim/init.vim'

# ranger起動簡略化用エイリアス
alias rng='ranger'
# rc.conf(ranger)の設定簡略化用エイリアス
alias rngconf='vim ~/dotfiles/.config/ranger/rc.conf'

# 基本コマンドのエイリアス
alias ls='ls --color=auto'
alias la='ls -la'
alias apep='autopep8 --in-place --aggressive --aggressive'
#alias xmind='~/xmind/xmind.sh &'
alias e='emacs'
alias g='git'

if [ $SHLVL = 1 ]; then
    alias t="tmuxp load ~/.tmuxp/config.yaml"
fi

# windowsのchromeとdeepl(chromeから)にエイリアスでアクセスする

if [ ! -e "/mnt/c/'Program Files'/Google/Chrome/Application" ]; then
    alias c="/mnt/c/'Program Files'/Google/Chrome/Application/chrome.exe"
    alias deepl="/mnt/c/'Program Files'/Google/Chrome/Application/chrome.exe https://www.deepl.com/ja/translator"
fi

# ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

setopt prompt_subst

# Ctrl + n, pで履歴を遡る
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history

function ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

function rprompt-ranger-level() {
    if [ -z "$RANGER_LEVEL" ]; then
        echo ""
    else
        echo "%F{050}  %f"
    fi
}

# ==============================================================================
# 
# プロンプト関係
# 
# ==============================================================================

# 通常のプロンプトです。
# PROMPT="%F{050}%c %# %f%k"
# PROMPT="%F{050}%c   %f%k"
PROMPT="%F{050}  %c 
  %f%k"
# for や while 、複数行入力時等に表示されるプロンプトです。
PROMPT2="> "
# 右に表示するプロンプトです。
RPROMPT_RNG='`rprompt-ranger-level`'
RPROMPT_GIT='`rprompt-git-current-branch`'
RPROMPT=${RPROMPT_RNG}${RPROMPT_GIT}"%F{050}  [%m]%f%k"

# 右プロンプトまで入力が来たら消すようにします。
setopt transient_rprompt

# ==============================================================================
# 
# 補完関係
# 
# ==============================================================================

# 標準の保管設定を行います。
autoload -Uz compinit
compinit

# ディレクトリ名を入力するだけでカレントディレクトリを変更します。
setopt auto_cd

# ディレクトリを移動したら自動でlsします。
function chpwd() { ls --color=auto }

# タブキー連打で保管候補を順に表示します。
setopt auto_menu

# 自動修正機能(候補を表示)を使います。
setopt correct

# 保管候補一覧でファイルの種別を表す識別マークを表示(ls -F の記号)します。
setopt list_types

# パスの最後につくスラッシュを自動的に削除しないようにします。
setopt noautoremoveslash

# = 以降でも保管できるようにします(--prefix=/usr のような場合)。
setopt magic_equal_subst

# 保管候補リストの日本語を正しく表示するようにします。
setopt print_eight_bit

# 補完時に大文字小文字を区別しないようにします(但し、大文字を打った場合は小文字に変換しません)。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ls コマンドの保管候補にも色つき表示を行います。
eval `dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# kill の候補にも色つき表示を行います。
zstyle ':completion:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# Shift-Tabで補完を逆順する
bindkey "^[[Z" reverse-menu-complete

# 選択肢の塗りつぶし
zstyle ':completion:*' menu select

# pipenvの補完
# eval "$(pipenv --completion)"

# ==============================================================================
# 
# 履歴関係
# 
# ==============================================================================

# ヒストリーファイルのパスを設定します。
HISTFILE=~/.zsh_history

# ヒストリに保存するコマンド数です。
HISTSIZE=10000

# ヒストリファイルに保存するコマンド数です。
SAVEHIST=10000

# 重複するコマンド行は古い方を削除します。
setopt hist_ignore_all_dups

# 直前と同じコマンドラインはヒストリに追加しないようにします。
setopt hist_ignore_dups

# コマンド履歴ファイルを共有します。
setopt share_history

# 履歴をインクリメンタルに追加します。
setopt inc_append_history

# history コマンドは履歴に登録しません。
setopt hist_no_store

# 余分な空白は詰めて記録します。
setopt hist_reduce_blanks

# 先頭がスペースの場合、ヒストリに追加しません。
setopt hist_ignore_space

# cd - と入力して Tab キーで今までに移動したディレクトリを一覧表示します。
setopt auto_pushd

# ディレクトリスタックで重複する古い方を削除することにします。
setopt pushd_ignore_dups

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

