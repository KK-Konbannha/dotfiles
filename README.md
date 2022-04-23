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
)


for p in $PRE_REQUISITES
do
    yes | sudo apt install $p
done

sudo apt remove vim
sudo npm install -g yarn
```
