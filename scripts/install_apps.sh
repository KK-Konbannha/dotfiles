# コマンドの有無確認
has() {
  type "$1" > /dev/null 2>&1
}

install_app() {
  local packages=("$@")
  if has "paru"; then
    paru -S --noconfirm --needed ${packages[@]}
  elif has "yay"; then
    yay -S --noconfirm --needed ${packages[@]}
  else
    echo -e "${red}[*] Error: Aur helper is required.${no_color}"
  fi
}

if ! has "paru" || ! has "yay";then
  echo -e "${red}[*] Error: Aur helper is required.${no_color}"
fi

echo -e "${green}[*] Select installing apps options.${no_color}"
echo -e "${green}[*] 1. All${no_color}"
echo -e "${green}[*] 2. For CUI${no_color}"
echo -e "${green}[*] 3. For GUI${no_color}"
read -p "[*] Your choice: " options

CUI_APPS=(
   archlinux-keyring
   sudo
   networkmanager
   less
   tree
   man-db
   neovim-nightly
   python-pynvim
   tinyxxd
   unzip
   git
   openssh
   wget
   which
   zsh
   mpd
   inetutils
   fzf               # A command-line fuzzy finder
   fd                # A simple, fast and user-friendly alternative to 'find'
   yazi-git          # ⚡️ Blazing Fast Terminal File Manager
   7zip
   zoxide            # A smarter cd command
   jq                # Command-line JSON processor
   ripgrep           # A line-oriented search tool that recursively searches the current directory for a regex pattern
   fastfetch
   lsd               # The next gen ls command
   gotop             # A terminal based graphical activity monitor
   sheldon           # Fast, configurable, shell plugin manager
   bat               # A cat(1) clone with wings

   deno
   lua-language-server
   pyright
   stylua
   luarocks-git
)

GUI_APPS=(
   hyprland
   hyprpaper
   polkit-kde-agent
   xdg-desktop-portal-hyprland
   dunst # nofification daemon
   wl-clipboard
   waybar
   sddm
   xdg-utils
  
   pipewire
   pipewire-alsa
   pipewire-pulse
   pipewire-jack
   wireplumber

   noto-fonts
   noto-fonts-cjk
   noto-fonts-emoji
   ttf-ubuntu-font-family
   otf-font-awesome
   pavucontrol

   fcitx5-git
   fcitx5-skk
   fcitx5-configtool

   gimp
   discord
   rofi-wayland
   firefox
   google-chrome
   thunar
   wezterm-git
   neovide
   ristretto # image viwer
   obs-studio
   parole # video player
   wev # wayland xev
)

if [ "${options}" -eq 1 ]; then
  install_app "${CUI_APPS[@]}" "${GUI_APPS[@]}"

elif [ "${options}" -eq 2 ]; then
  install_app "${CUI_APPS[@]}"

elif [ "${options}" -eq 3 ]; then
  install_app "${GUI_APPS[@]}"

fi

