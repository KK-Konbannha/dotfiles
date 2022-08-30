import os
import json


def install_arch_app():
    with open("../app_list/arch_app_list.json") as f:
        d_update = json.load(f)
        print(d_update)
