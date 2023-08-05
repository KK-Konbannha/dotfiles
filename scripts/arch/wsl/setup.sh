mkdir -p "${HOME}/tmp/xorgxrdp-logs"

# pacmanのダウンロード元を設定
sudo sed -i.dist \
    -e 's/^Server/#Server/g' \
    -e 's!#Server = \(https\?://.*\?\.jp\)!Server = \1!g' \
    /etc/pacman.d/mirrorlist

# pacmanの更新
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy archlinux-keyring

enable systemd(by distrod)
curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"
chmod +x install.sh
sudo ./install.sh install
sudo /opt/distrod/bin/distrod enable
cd ${HOME}
