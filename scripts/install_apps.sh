#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
no_color=$(tput sgr0)

APP_LIST_FILE="app_list.norg"

if [ ! -f "${APP_LIST_FILE}" ]; then
  echo "Error: ${APP_LIST_FILE} not found."
  exit 1
fi

CUI_START_LINE=$(sed -e '/^\* CUI/!d' -e '=' -e '/^\* /d' app_list.norg)
GUI_START_LINE=$(sed -e '/^\* GUI/!d' -e '=' -e '/^\* /d' app_list.norg)

if [ -z "${CUI_START_LINE}" ] || [ -z "${GUI_START_LINE}" ]; then
  echo "${red}Error: Can't find CUI or GUI categories in ${APP_LIST_FILE}.${no_color}"
  exit 1
fi

if [ $((CUI_START_LINE)) -gt $((GUI_START_LINE)) ]; then
  echo "${red}Error: CUI category should be above GUI category in ${APP_LIST_FILE}.${no_color}"
  exit 1
fi

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
echo -e ""
read -p "[*] Your choice: " options
echo -e ""

if [ "${options}" -eq 1 ]; then
  # install_app "${CUI_APPS[@]}" "${GUI_APPS[@]}"
  echo

elif [ "${options}" -eq 2 ]; then
  # # CUIアプリのカテゴリーを取得
  # CUI_CATEGORY=$(sed -e "${CUI_START_LINE}d" \
  #   -e "$(($CUI_START_LINE + 1)),$(($GUI_START_LINE -1)) {/^\*\* /!d}" \
  #   -e "$(($CUI_START_LINE + 1)),$(($GUI_START_LINE -1)) {s/^\*\* //}" \
  #   -e "$GUI_START_LINE,\$d" $APP_LIST_FILE |
  #   awk '{ printf "[*] %d. %s\n", NR + 1, $0 }' )

  # echo -e "${green}[*] Select Categories.(e.g. 1,3,4)${no_color}"
  # echo -e "${green}[*] 1. all${no_color}"
  # echo -e "${green}${CUI_CATEGORY}${no_color}"
  # echo -e ""
  # read -p "[*] Your choice: " selected_categories
  # echo -e ""

  # if [ -z "${selected_categories}" ]; then
  #   echo -e "${red}[*] Error: No categories selected.${no_color}"
  #   exit 1
  # fi

  # selected_categories=$(echo "${selected_categories}" | grep -oE '[0-9]+' )
  # categories_num=$(echo "${selected_categories}" | wc -w)
  # for selected_category in ${selected_categories}; do
  #   if [ "${selected_category}" -gt "${categories_num}" ]; then
  #     echo -e "${red}[*] Error: Invalid category number.${no_color}"
  #     exit 1
  #   fi

  #   if [ "${selected_category}" -eq 1 ]; then
  #   else
  #   fi
  # done

  # install_app "${CUI_APPS[@]}"
elif [ "${options}" -eq 3 ]; then
  # install_app "${GUI_APPS[@]}"
  echo

fi

