# プロンプトの表示時に変数を展開できるように
setopt prompt_subst
# 右プロンプトまで入力が来たら消すようにします。
setopt transient_rprompt

# 関数 "{{{
# ---------------------------------------------------------------------
function lprompt-icon {
    dirInt=$(python -c "import sys;x = sys.argv[1].split('/');print(4 if x == ['',''] else (len(x)-1)%4)" $(pwd))
    randInt=$(python -c "import random;print(str(random.randint(44, 49)).zfill(3));")
    echo -n "%F{$randInt}"
    if [ $dirInt -eq 4 ]; then
        echo -n " "
    elif [ $dirInt -eq 1 ]; then
        echo -n " "
    elif [ $dirInt -eq 2 ]; then
        echo -n " "
    elif [ $dirInt -eq 3 ]; then
        echo -n " "
    elif [ $dirInt -eq 0 ]; then
        echo -n " "
    fi
    echo "%f"
}

#  ╭──────────────────────────────────────────────────────────╮
#  │          ブランチ名を色付きで表示させるメソッド          │
#  ╰──────────────────────────────────────────────────────────╯
# right "{{{
# ---------------------------------------------------------------------
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
#}}}

# left "{{{
# ---------------------------------------------------------------------
function lprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    echo "%F{050}%c"
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{050}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}%c "
}
#}}}

#  ╭──────────────────────────────────────────────────────────╮
#  │         venvに入ったときにそのことが分かるように         │
#  ╰──────────────────────────────────────────────────────────╯
function lprompt-venv() {
  if [ -z "$VIRTUAL_ENV" ]; then
    echo ""
  else
    echo "%F{011}  $(basename ${VIRTUAL_ENV}) %f"
  fi
}

#  ╭──────────────────────────────────────────────────────────╮
#  │          コマンドのあとに空行を挿入できるように          │
#  ╰──────────────────────────────────────────────────────────╯
function add-newline() {
  if [[ -z $PS1_NEWLINE_LOGIN ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    echo
  fi
}

function precmd() {
  add-newline
}

#}}}

# プロンプト "{{{
# ---------------------------------------------------------------------

#  ╭──────────────────────────────────────────────────────────╮
#  │                   プロンプトで使う関数                   │
#  ╰──────────────────────────────────────────────────────────╯
LPROMPT_ICON='`lprompt-icon`'
LPROMPT_GIT='`lprompt-git-current-branch`'
LPROMPT_VENV='`lprompt-venv`'
RPROMPT_GIT='`rprompt-git-current-branch`'

#  ╭──────────────────────────────────────────────────────────╮
#  │                  通常のプロンプトです。                  │
#  ╰──────────────────────────────────────────────────────────╯
# PROMPT="%F{050}%c %# %f%k"
PROMPT="%F{241}╭─ %f${LPROMPT_ICON} ${LPROMPT_GIT} ${LPROMPT_VENV}%F{050}
%F{241}╰─%f %f%k"
#  ╭──────────────────────────────────────────────────────────╮
#  │for や while 、複数行入力時等に表示されるプロンプトです。 │
#  ╰──────────────────────────────────────────────────────────╯
PROMPT2="> "
#  ╭──────────────────────────────────────────────────────────╮
#  │               右に表示するプロンプトです。               │
#  ╰──────────────────────────────────────────────────────────╯
RPROMPT=${RPROMPT_GIT}"%F{050}  [%m]%f%k"

#}}}

# vim: set foldmethod=marker foldlevel=0:
