#!/bin/bash
# ubuntu(wsl2)用のインストール方法
set -eu

DOT_DIRECTORY="${HOME}/dotfiles"
REMOTE_URL="git@github.com:KK-Konbannha/dotfiles.git"
OVERWRITE=false

# 使い方
usage() {
    name=`basename $0`
    cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  deploy
  init
Arguments:
  -f $(tput setaf 1)** warning **$(tput sgr0) Overwrite dotfiles.
  -h Print help (this message)
EOF
exit 1
}

# オプション -fは上書き、-hはヘルプ表示
while getopts :f:h opt; do
    case ${opt} in
        f)
            OVERWRITE=true
            ;;
        h)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

# 上書き可or存在しない場合にdotfiles作成
if [ -n "${OVERWRITE}" -o ! -d ${DOT_DIRECTORY} ]; then
    echo "Downloading dotfiles..."
    rm -rf ${DOT_DIRECTORY}
    git clone ${REMOTE_URL}

    echo $(tput setaf 2)Downloading dotfiles complete!. ✔︎$(tput sgr0)
fi

link_files() {
    # dotfiles以下のファイルのリンクをホームに作成する。

    echo ""
    echo -E "      _               _ "
    echo -E "     | |             | | "
    echo -E "   __| |  ___  _ __  | |  ___   _   _ "
    echo -E "  / _\` | / _ \\| '_ \\ | | / _ \\ | | | | "
    echo -E " | (_| ||  __/| |_) || || (_) || |_| | "
    echo -E "  \\__,_| \\___|| .__/ |_| \\___/  \\__, | "
    echo -E "              | |                __/ | "
    echo -E "              |_|               |___/ "
    echo ""

    for f in .??*
    do
        [[ ${f} == ".git" ]] && continue
        [[ ${f} == ".gitignore" ]] && continue

        if [[ $f == ".config" ]]; then
            for ff in .config/??*
            do
                ln -snfv ${DOT_DIRECTORY}/${ff} ${HOME}/${f}
            done
        else
            ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
        fi
    done
    echo $(tput setaf 2)Deploying dotfiles complete!. ✔︎$(tput sgr0)
}

initalize() {
    echo ""
    echo "      _         _     __  _  _ "
    echo "     | |       | |   / _|(_)| | "
    echo "   __| |  ___  | |_ | |_  _ | |  ___  ___ "
    echo "  / _\` | / _ \\ | __||  _|| || | / _ \\/ __| "
    echo " | (_| || (_) || |_ | |  | || ||  __/\\__ \\ "
    echo "  \\__,_| \\___/  \\__||_|  |_||_| \\___||___/ "
    echo ""
    echo ""

    # aptのアップデート
    sudo apt update && sudo apt upgrade

    # 必要ディレクトリ作成
    mkdir -p ~/.config
    mkdir -p ~/.Trash
    mkdir -p ~/tmp
    mkdir -p ~/dev
    mkdir -p ~/Downloads

    # vimの削除
    sudo apt remove vim && sudo apt autoremove

    # インストールするパッケージリスト
    PRE_REQUISITES=(
        tree
        zsh
        tmuxp
        ranger
        locales-all
        libgmp-dev
        libgmp3-dev
        libicu-dev
        libncurses-dev
        zlib1g-dev
    )

    for p in $PRE_REQUISITES
    do
        yes | sudo apt install $p
    done

    # nvimのインストール
    curl -OL "https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb"
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor


    # yarn
    sudo npm install -g yarn

    # deno
    curl -fsSL https://deno.land/x/install/install.sh | sh

    # zplug
    if [[ ! -d ${DOT_DIRECTORY}/.zplug ]];then
        git clone https://github.com/zplug/zplug ~/dotfiles/.zplug
    fi

    # ghcup
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

    # シェルをzshにする
    [ ${SHELL} != "/bin/zsh"  ] && chsh -s /bin/zsh
    echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"

    # 作業ディレクトリを戻す
    cd ${DOT_DIRECTORY}

    link_files
}


# 引数によって場合分け
command=$1
[ $# -gt 0 ] && shift

# 引数がなければヘルプ
case $command in
    deploy)
        link_files
        ;;
    init*)
        initialize
        ;;
    *)
        usage
        ;;
esac

exit 0
