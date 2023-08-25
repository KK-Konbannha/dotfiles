#bin/sh

cat ~/dotfiles/app_list/app_list_gui.txt ~/dotfiles/app_list/app_list_cui.txt | sort | uniq > ~/dotfiles/app_list/app_list_for_arch.txt

~/dotfiles/bin/remove_first_line ~/dotfiles/app_list/app_list_for_arch.txt
