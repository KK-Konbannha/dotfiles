#!/bin/bash

DOTPATH=~/dotfiles

deploy() {
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
        [[ $f == ".git" ]] && continue
        [[ $f == ".gitignore" ]] && continue

        if [[ $f == ".config" ]]; then
            for ff in .config/??*
            do
                ln -snfv $DOTPATH/$ff $HOME/$f
            done
        else
            ln -snfv $DOTPATH/$f $HOME/$f
        fi
    done
}

initalize() {
    # deinとzplugのインストール。
    
    echo ""
    echo "      _         _     __  _  _ "
    echo "     | |       | |   / _|(_)| | "
    echo "   __| |  ___  | |_ | |_  _ | |  ___  ___ "
    echo "  / _\` | / _ \\ | __||  _|| || | / _ \\/ __| "
    echo " | (_| || (_) || |_ | |  | || ||  __/\\__ \\ "
    echo "  \\__,_| \\___/  \\__||_|  |_||_| \\___||___/ "
    echo ""
    echo ""

    mkdir -p ~/.config
    mkdir -p ~/.Trash
    mkdir -p ~/tmp
    mkdir -p ~/Downloads

    # zplug
    if [[ ! -d $DOTPATH/.zplug ]];then
        git clone https://github.com/zplug/zplug ~/dotfiles/.zplug
    fi

    chsh -s `which zsh`
    
    # dein
    mkdir -p ~/.cache/dein
    cd ~/.cache/dein
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.cache/dein


    # 作業ディレクトリを戻す
    cd ~/dotfiles

    deploy
}


if [ $1 = "deploy" -o $1 = "-d" ]; then
    deploy
elif [ $1 = "init" -o $1 = "-i" ]; then
    initalize
else
    echo "-d or -i is needed"
fi
