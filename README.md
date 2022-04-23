# dotfiles

# Ubuntu(wsl2)
```bash
sudo apt update && sudo apt upgrade

PRE_REQUISITES=(
    tree
    zsh
    neovim
    tmuxp
    nodejs
    npm
    ranger
    locales-all
    ghc
    cabal-install
    haskell-stack
)


for p in $PRE_REQUISITES
do
    yes | sudo apt install $p
done

sudo apt remove vim
sudo npm install -g yarn

cd ~
git clone https://github.com/KK-Konbannha/dotfiles.git

cd dotfiles
chmod 777 install.sh
./install.sh -i
```
