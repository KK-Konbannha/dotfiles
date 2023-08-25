# xrdpのインストール
paru -S xrdp xorgxrdp
sudo sh -c "echo 'allowed_users=anybody' >/etc/X11/Xwrapper.config"
sudo systemctl enable xrdp
sudo systemctl enable xrdp-sesman
sudo sed -i -e 's/FuseMountName=thinclient_drives/FuseMountName=.thinclient_drives/' /etc/xrdp/sesman.ini
sudo sed -i -e "s/=\.xorg/=tmp\/xorgxrdp-logs\/.xorg/" /etc/xrdp/sesman.ini

sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.bak
sudo sed -i 's/3389/3390/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/max_bpp=32/#max_bpp=32\nmax_bpp=128/g' /etc/xrdp/xrdp.ini
sudo sed -i 's/xserverbpp=24/#xserverbpp=24\nxserverbpp=128/g' /etc/xrdp/xrdp.ini
