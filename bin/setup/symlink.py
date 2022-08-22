import os


def symlink_dotfiles(files_should_exclude):
    dotfiles_dir = os.path.expanduser("~/dotfiles")
    if not os.path.lexists(dotfiles_dir):
        raise Exception("Dotfiles doesn't exist!!")

    dotfiles = os.listdir(dotfiles_dir)

    remaining_dotfiles = [f for f in dotfiles if f not in files_should_exclude]
