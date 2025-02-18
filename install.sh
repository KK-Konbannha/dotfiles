#!/bin/bash
set -eu

cd ${HOME}

DOT_DIRECTORY="${HOME}/dotfiles"
REMOTE_URL="https://github.com/KK-Konbannha/dotfiles.git"

# 使い方
usage() {
    name=$(basename "$0")
    cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  deploy  Deploy the dotfiles
  init    Initialize (default if no command is provided)
Arguments (optional):
  -h      Print help (this message)
EOF
exit 1
}

# コマンドの有無確認
has() {
  type "$1" > /dev/null 2>&1
}

# オプション -hはヘルプ表示
while getopts h opt; do
    case ${opt} in
        h)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

# 存在しない場合にdotfiles作成
if [ ! -d ${DOT_DIRECTORY} ]; then
    echo "Downloading dotfiles..."
    rm -rf ${DOT_DIRECTORY}
    if has "git"; then
        git clone ${REMOTE_URL}
    else
        echo "git is required"
    fi

    echo $(tput setaf 2)Downloading dotfiles complete!. ✔︎$(tput sgr0)
fi

link_files() {
    # dotfiles以下のファイルのリンクをホームに作成する。

    # 作業ディレクトリを変更
    cd ${DOT_DIRECTORY}

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
            for ff in ${DOT_DIRECTORY}/.config/*
            do
                ln -snfv ${ff} ${HOME}/.config/
            done
        else
            ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
        fi
    done

    echo $(tput setaf 2)Deploying complete!. ✔︎$(tput sgr0)


    # 作業ディレクトリを戻す
    cd ${HOME}
}

initialize() {
    # 作業ディレクトリを変更
    cd ${HOME}

    echo ""
    echo "      _         _     __  _  _ "
    echo "     | |       | |   / _|(_)| | "
    echo "   __| |  ___  | |_ | |_  _ | |  ___  ___ "
    echo "  / _\` | / _ \\ | __||  _|| || | / _ \\/ __| "
    echo " | (_| || (_) || |_ | |  | || ||  __/\\__ \\ "
    echo "  \\__,_| \\___/  \\__||_|  |_||_| \\___||___/ "
    echo ""
    echo ""
    echo ""
    echo ""

    # 必要ディレクトリ作成
    mkdir -p "${HOME}/.config"
    mkdir -p "${HOME}/.mpd/playlists"
    mkdir -p "${HOME}/tmp"
    mkdir -p "${HOME}/dev"
    mkdir -p "${HOME}/Music"
    mkdir -p "${HOME}/Wallpapers"
    mkdir -p "${HOME}/Downloads"

    # vimのアンインストール
    if has "vim" && ! has "nvim"; then
        sudo pacman -R vim
    fi
    # paruのインストール
    if ! has "paru"; then
        cd /tmp
        sudo pacman -Syu --needed git base-devel
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
        cd ${HOME}
    fi

    source ${HOME}/dotfiles/scripts/install_app.sh

    # シェルをzshにする
    [ ${SHELL} != "/bin/zsh"  ] && chsh -s /bin/zsh
    echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"

    link_files

    cd ${HOME}
}


# 引数によって場合分け
if [ $# = 0 ]; then
    command=""
else
    command=$1
fi

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
