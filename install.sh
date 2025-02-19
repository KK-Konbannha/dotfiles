#!/bin/bash
set -eu

red=$(tput setaf 1)
green=$(tput setaf 2)
no_color=$(tput sgr0)

DOT_DIR="${HOME}/dotfiles"
XDG_CONFIG_DIR="${DOT_DIR}/.config"
SCRIPTS_DIR="${DOT_DIR}/scripts"

# コマンドの有無確認
has() {
  type "$1" > /dev/null 2>&1
}

git_clone() {
  umask 022
  echo -e "${green}[*] Cloning dotfiles.${no_color}"
  git clone https://github.com/KK-Konbannha/dotfiles.git ${DOT_DIR}
}

create_dirs() {
  echo -e "${green}[*] Creating directories.${no_color}"

  mkdir -p "${HOME}/.config"
  mkdir -p "${HOME}/.mpd/playlists"
  mkdir -p "${HOME}/tmp"
  mkdir -p "${HOME}/dev"
  mkdir -p "${HOME}/Music"
  mkdir -p "${HOME}/Wallpapers"
  mkdir -p "${HOME}/Downloads"
}

install_aur_helper() {
  echo -e "${green}[*] Select aur helper (enter number e.g. yay - 1).${no_color}"
  echo -e "${green}[*] 1. paru${no_color}"
  echo -e "${green}[*] 2. yay${no_color}"
  read -p "[*] Your choice: " aur_helper

  if [ "${aur_helper}" -eq 1 ];then
    echo -e "${green}[*] You selected: paru${no_color}"

    if  has "paru"; then
      echo -e "${green}[*] You have installed paru.${no_color}"

    else
        current_dir=$(pwd)

        cd /tmp
        sudo pacman -Syu --needed git base-devel
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si

        cd ${current_dir}

    fi

  elif [ "${aur_helper}" -eq 2 ]; then
    echo -e "${green}[*] You selected: yay${no_color}"

    if  has "yay"; then
      echo -e "${green}[*] You have installed yay.${no_color}"

    else
        current_dir=$(pwd)

        cd /tmp
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si

        cd ${current_dir}

    fi

  else
    echo -e "${red}[*] Error: invalid number or input.${no_color}"
    exit
  fi
}

link_files() {
  echo -e "${green}[*] Deploying dotfiles.${no_color}"

  shopt -s globstar dotglob

  ls -d1 ${DOT_DIR}/.??* \
    | sed -e '/git/d' -e '/config/d' \
    | sed 's!^.*/!!' \
    | xargs -I{} ln -snfv ${DOT_DIR}/{} ${HOME}/{}

  if [ -d ${XDG_CONFIG_DIR} ] && [ -d ${HOME}/.config ]; then
    ls -1 ${XDG_CONFIG_DIR} | xargs -I{} ln -snfv ${XDG_CONFIG_DIR}/{} ${HOME}/.config/{}
  fi

  shopt -u globstar dotglob
}

switch_shell() {
  echo -e "${green}[*] Switching the default shell.${no_color}"

  if ! has "zsh"; then
    sudo pacman -S zsh
  fi

  [ ${SHELL} != "/bin/zsh"  ] && chsh -s /bin/zsh
}

replace_vim_with_nvim() {
  if has "vim" && [ ! -L /usr/bin/vim ]; then
      echo -e "${green}[*] Uninstalling Vim.${no_color}"
      sudo pacman -Rs vim
  fi

  if ! has "nvim"; then
      echo -e "${green}[*] Installing Neovim.${no_color}"
    sudo pacman -S neovim python-pynvim
  fi

  echo -e "${green}[*] Linking Neovim as Vim.${no_color}"
  sudo ln -sf $(which nvim) /usr/bin/vim

}


while true; do
    clear
    echo -e "${green}Konbannha dotfiles${no_color}"
    ! has "git" && echo -e "${red}You need git.${no_color}" && exit

    echo -e "${green}[*] Choose option.${no_color}"
    echo -e "1. All of the below."
    echo -e "2. Clone dotfiles from github.com."
    echo -e "3. Create the necessary directories."
    echo -e "4. Deploy dotfiles."
    echo -e "5. Install aur helper."
    echo -e "6. Install applications."
    echo -e "7. Switch the default shell to zsh."
    echo -e "8. Replace Vim with Neovim."
    echo -e "9. Exit."
    read -p "[*] Your choice: " x
    case $x in
        [1]* ) git_clone; create_dirs; link_files; install_aur_helper; source ${SCRIPTS_DIR}/install_apps.sh; switch_shell; replace_vim_with_nvim;  exit;;
        [2]* ) git_clone; exit;;
        [3]* ) create_dirs; exit;;
        [4]* ) link_files; exit;;
        [5]* ) install_aur_helper; exit;;
        [6]* ) source ${SCRIPTS_DIR}/install_apps.sh; exit;;
        [7]* ) switch_shell; exit;;
        [8]* ) replace_vim_with_nvim; exit;;
        [9]* ) exit;;
        * )  echo -e "${red}[*] Error: invalid number or input.${no_color}";;
    esac
done
