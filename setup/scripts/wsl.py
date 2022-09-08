from exec_sh import exec_sh


def setup_wsl(DIST):
    if DIST == "A":
        exec_sh("wsl/setup.sh")
        exec_sh("install-paru.sh")
        exec_sh("wsl/set-xrdp.sh")
    else:
        pass
