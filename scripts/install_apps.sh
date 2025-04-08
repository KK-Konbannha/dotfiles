#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
no_color=$(tput sgr0)

APP_LIST_FILE="app_list.toml"

if [ ! -f "${APP_LIST_FILE}" ]; then
  echo "Error: ${APP_LIST_FILE} not found."
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
  echo -e "${green}[*] Install all aplications."

  apps=($(./toml_parser All))

  install_app "${apps[@]}"

  exit 0
fi

if [ "${options}" -eq 2 ]; then
  ui_kind="CUI"
elif [ "${options}" -eq 3 ]; then
  ui_kind="GUI"
fi

echo -e "${green}[*] Install ${ui_kind} aplications."

# ui_kindのアプリのカテゴリーを取得
categories=$(./toml_parser ${ui_kind} name |
  awk '{ printf "[*] %d. %s\n", NR + 1, $0 }')

  
echo -e "${green}[*] Select Categories.(e.g. 1,3,4)${no_color}"
echo -e "${green}[*] 1. all${no_color}"
echo -e "${green}${categories}${no_color}"
echo -e ""
read -p "[*] Your choice: " selected_categories
echo -e ""

if [ -z "${selected_categories}" ]; then
  echo -e "${red}[*] Error: No categories selected.${no_color}"
  exit 1
fi

categories_num=$(echo "${categories}" | wc -l)
selected_categories=$(echo "${selected_categories}" | grep -oE '[0-9]+' )

selected_category_names=()
for selected_category in ${selected_categories}; do
  # 選択された番号かカテゴリーの総数より大きい場合
  if [ $((${selected_category})) -gt $((${categories_num} + 1)) ]; then
    echo -e "${red}[*] Error: Invalid category number.${no_color}"
    exit 1
  fi

  if [ "${selected_category}" -eq 1 ]; then
    selected_category_names=("All")
    break
  else
    # 番号に該当するカテゴリーの名前をselected_category_nameに取り出す
    selected_category_name=$(echo "${categories}" |
      sed -e "/${selected_category}/!d" \
      -e "s/\[\*\] .\. //")

    selected_category_names+=($selected_category_name)
  fi
done
apps=($(./toml_parser ${ui_kind} app $selected_category_names))

install_app "${apps[@]}"

exit 0
