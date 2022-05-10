import os
import random


def get_wallpaper_path(wallpapers_dir_path):
    wallpapers_dir_exists = os.path.isdir(wallpapers_dir_path)

    if wallpapers_dir_exists:
        wallpapers_list = os.listdir(wallpapers_dir_path)
        number_of_wallpapers = len(wallpapers_list)
        if not number_of_wallpapers:
            return None
        selected_wallpaper_number = random.randint(1, number_of_wallpapers) - 1
        selected_wallpaper_name = wallpapers_list[selected_wallpaper_number]
        selected_wallpaper_path = f"{wallpapers_dir_path}/{selected_wallpaper_name}"
        return selected_wallpaper_path
    else:
        return None
