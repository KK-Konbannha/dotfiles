# コマンドの有無確認
has() {
  type "$1" > /dev/null 2>&1
}

if ! has "paru" || ! has "yay";then
  echo -e "${red}[*] Error: Aur helper is required.${no_color}"
fi

echo -e "${green}[*] Installing applications.${no_color}"

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
if has "paru"; then
  paru -S --noconfirm --needed ${PRE_REQUISITES[@]}
elif has "paru"; then
  yay -S --noconfirm --needed ${PRE_REQUISITES[@]}
fi
