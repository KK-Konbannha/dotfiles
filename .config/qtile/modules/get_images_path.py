import os
import random
import datetime


def get_random_wallpaper_path(wallpapers_dir_path):
    wallpapers_dir_exists = os.path.isdir(wallpapers_dir_path)

    if wallpapers_dir_exists:
        wallpapers_list = os.listdir(wallpapers_dir_path)
        number_of_wallpapers = len(wallpapers_list)
        if not number_of_wallpapers:
            return None
        selected_wallpaper_number = random.randint(1, number_of_wallpapers) - 1
        selected_wallpaper_name = wallpapers_list[selected_wallpaper_number]
        selected_wallpaper_path = (
            f"{wallpapers_dir_path}/{selected_wallpaper_name}"
        )
        return selected_wallpaper_path
    else:
        return None


def get_black_wallpaper_path():
    return os.path.expanduser("~/.config/qtile/wall/black.png")


def get_the_twelve_image_path():
    image_dir = os.path.expanduser("~/.config/qtile/png")
    month = datetime.date.today().strftime("%m")
    image_name = next(filter(lambda x: month in x, os.listdir(image_dir)))
    image_path = f"{image_dir}/{image_name}"
    return image_path
