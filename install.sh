#!/bin/bash
# ubuntu(wsl2)用のインストール方法
set -eu

cd ${HOME}

DOT_DIRECTORY="${HOME}/dotfiles"
REMOTE_URL="git@github.com:KK-Konbannha/dotfiles.git"

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

# コマンドの有無確認
has() {
  type "$1" > /dev/null 2>&1
}

# ディストリビューションのチェック
check_dist() {
    echo -n "Ubuntu or Arch? [U/A]: "
    read dist
    case ${dist} in
        [uU])
            echo -n "Ubuntu? [Y/n]: "
            read answer
            if test ${answer} = "y" -o ${answer} = "Y"; then
                dist="Ubuntu"
            else
                check_dist
            fi
            ;;
        [aA])
            echo -n "Arch? [Y/n]: "
            read answer
            if test ${answer} = "y" -o ${answer} = "Y"; then
                dist="Arch"
            else
                check_dist
            fi
            ;;
        *)
            check_dist
            ;;
    esac
}

# オプション -hはヘルプ表示
while getopts fh opt; do
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
    elif has "curl"; then
        tarball="https://github.com/KK-Konbannha/dotfiles/archive/main.tar.gz"

        curl -L "$tarball" | tar zxv

        mv -f dotfiles-main $DOT_DIRECTORY
    else
        echo "git or curl required"
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
            for ff in .config/??*
            do
                ln -snfv ${DOT_DIRECTORY}/${ff} ${HOME}/${f}
            done
        else
            ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
        fi
    done
    echo $(tput setaf 2)Deploying dotfiles complete!. ✔︎$(tput sgr0)

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
    rm -rf "${HOME}/.config"
    rm -rf "${HOME}/.Trash"
    rm -rf "${HOME}/tmp"
    mkdir -p "${HOME}/.config"
    mkdir -p "${HOME}/.Trash"
    mkdir -p "${HOME}/tmp"
    mkdir -p "${HOME}/dev"
    mkdir -p "${HOME}/Downloads"

    # ディストリビューションのチェック"
    check_dist

    if [ ${dist} = "Ubuntu" ]; then

        # aptのアップデート
        sudo apt update && sudo apt upgrade

        # vimの削除
        sudo apt remove vim && sudo apt autoremove

        # インストールするパッケージリスト
        PRE_REQUISITES_UBUNTU=(
            zsh
            gcc
            make
            tree
            tmuxp
            ranger
            unzip
            locales-all
            libgmp-dev
            libgmp3-dev
            libicu-dev
            libncurses-dev
            zlib1g-dev
        )

        for p in ${PRE_REQUISITES_UBUNTU[@]}
        do
            yes | sudo apt install $p
        done
        echo $(tput setaf 2)Installing apps complete!. ✔︎$(tput sgr0)

        # nvimのインストール
        cd "${HOME}/Downloads"
        curl -OL "https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb"
        sudo apt install ./nvim-linux64.deb
        sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
        sudo update-alternatives --config vi
        sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
        sudo update-alternatives --config vim
        sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
        sudo update-alternatives --config editor
        echo $(tput setaf 2)Installing nvim complete!. ✔︎$(tput sgr0)
    elif [ ${dist} = "Arch" ]; then
        # pacmanのダウンロード元を設定
        sudo sed -i.dist \
            -e 's/^Server/#Server/g' \
            -e 's!#Server = \(https\?://.*\?\.jp\)!Server = \1!g' \
            /etc/pacman.d/mirrorlist

        # pacmanの更新
        sudo pacman-key --init
        sudo pacman-key --populate
        sudo pacman -Syy archlinux-keyring

        # yayのインストール
        sudo pacman -Syyuu --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay

        # enable systemd(by distrod)
        curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"
        chmod +x install.sh
        sudo ./install.sh install
        sudo /opt/distrod/bin/distrod enable

        # xrdpのインストール
        yay -S xrdp xorgxrdp
        sudo sh -c "echo 'allowed_users=anybody' >/etc/X11/Xwrapper.config"
        sudo systemctl enable xrdp
        sudo systemctl enable xrdp-sesman

        # インストールするパッケージリスト
        PRE_REQUISITES_ARCH_PACMAN=(
            zsh
            neovim
            gcc
            make
            tree
            unzip
            xorg-server
            xorg-xev
            xorg-xinit
            tk
            python3
            python-pip
            perl
            mplayer
        )

        PRE_REQUISITES_ARCH_AUR=(
            tmuxp
            ranger
            qtile
            termite
            mdr
        )

        for p in ${PRE_REQUISITES_ARCH_PACMAN[@]}
        do
            yes | sudo pacman -S $p
        done
        for p in ${PRE_REQUISITES_ARCH_AUR[@]}
        do
            yes | sudo yay -S $p
        done

        ln -s (which nvim) /usr/bin/vim

        echo $(tput setaf 2)Installing apps complete!. ✔︎$(tput sgr0)
    else
        echo "error"
        exit 1
    fi
        cd ${HOME}

    # vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo $(tput setaf 2)Installing vim-plug complete!. ✔︎$(tput sgr0)

    # nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    echo $(tput setaf 2)Installing nvm complete!. ✔︎$(tput sgr0)

    # npm
    nvm install node
    echo "$(tput setaf 2)Installing node & npm complete!. ✔︎$(tput sgr0)"

    # yarn
    # node_path=`nvm which current | sed "s/\/node\$//"`
    npm install -g yarn
    echo $(tput setaf 2)Installing yarn complete!. ✔︎$(tput sgr0)

    # deno
    curl -fsSL https://deno.land/x/install/install.sh | sh
    echo $(tput setaf 2)Installing deno complete!. ✔︎$(tput sgr0)

    # ghcup
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    echo $(tput setaf 2)Installing ghcup complete!. ✔︎$(tput sgr0)

    # zplug
    if [[ ! -d ${DOT_DIRECTORY}/.zplug ]];then
        git clone https://github.com/zplug/zplug ~/dotfiles/.zplug
    fi
    echo $(tput setaf 2)Installing zplug complete!. ✔︎$(tput sgr0)

    # シェルをzshにする
    [ ${SHELL} != "/bin/zsh"  ] && chsh -s /bin/zsh
    echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"

    link_files

    # 作業ディレクトリを戻す
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
