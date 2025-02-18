# コマンドの有無確認
has() {
  type "$1" > /dev/null 2>&1
}

if ! has "paru";then
  echo "paru is required"
fi
# インストールするパッケージリスト
PRE_REQUISITES=(
  archlinux-keyring
  networkmanager
  docker
  fzf
  fastfetch
  lsd
  tree
  neovim
  man-db
  unzip
  git
  gotop
  openssh
  wget
  which
  sheldon
  zsh

  deno

  hyprland
  polkit-kde-agent
  xdg-desktop-portal-hyprland
  dunst
  wl-clipboard

  pipewire
  pipewire-alsa
  pipewire-pulse
  pipewire-jack
  wireplumber

  noto-fonts-cjk
  noto-fonts-emoji
  gimp
  discord
  rofi-wayland
  fcitx5
  fcitx5-skk
  fcitx5-configtool
  firefox
  thunar
  wezterm-git
  ristretto
  xdg-utils
  pavucontrol
)
paru -S --noconfirm --needed ${PRE_REQUISITES[@]}

sudo ln -sf $(which nvim) /usr/bin/vim

echo $(tput setaf 2)Installing apps complete!. ✔︎$(tput sgr0)

cd ${HOME}

