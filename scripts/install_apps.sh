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
  sudo
  networkmanager
  docker
  fzf
  fd
  ranger
  fastfetch
  lsd
  less
  tree
  neovim
  python-pynvim
  tinyxxd
  man-db
  unzip
  git
  gotop
  openssh
  wget
  which
  sheldon
  zsh
  mpd

  deno
  lua-language-server
  pyright

  hyprland
  hyprpaper
  polkit-kde-agent
  xdg-desktop-portal-hyprland
  dunst # nofification daemon
  wl-clipboard
  waybar

  pipewire
  pipewire-alsa
  pipewire-pulse
  pipewire-jack
  wireplumber

  sddm
  noto-fonts-cjk
  noto-fonts-emoji
  ttf-ubuntu-font-family
  gimp
  discord
  rofi-wayland
  fcitx5-git
  fcitx5-skk
  fcitx5-configtool
  firefox
  google-chrome
  thunar
  wezterm-git
  neovide
  ristretto # image viwer
  xdg-utils
  pavucontrol
  obs-studio
  parole # video player
  wev # wayland xev
)
if has "paru"; then
  paru -S --noconfirm --needed ${PRE_REQUISITES[@]}
elif has "yay"; then
  yay -S --noconfirm --needed ${PRE_REQUISITES[@]}
else
  echo -e "${red}[*] Error: Aur helper is required.${no_color}"
fi
