# dotfiles

このdotfilesはwsl上のUbuntuとArch Linuxで動作します。（Ubuntuはリモートデスクトップは動きません）

Windowsのリモートデスクトップからwsl上のlinuxにアクセスすることで別pc、パーティション等にlinuxをクリーンインストールしたときと遜色ないデスクトップ環境を得ることが可能になっています。

環境はWindows11を想定しています。（筆者はhome edition）


## 使用ソフトウェア概要
OS: Arch Linux（リモートデスクトップを利用しないならUbuntuも）  
Window Manager: qtile  
terminal: kitty  
shell: zsh  
editor: neovim

これらに加えフォントはHackGen Nerdを使用、日本語入力にはfcitx5を使用、ファイルマネージャーとしてranger、筆者は使いこなせていないが一応tmuxの設定もあります。  
以前使用していたことからxresourcesにはurxvtの設定が残っています。  
また、使用プラグインの関係上node、npm、yarn、denoがインストールされるようになっています。（node、npmのインストールにはnvmを使用しています）  
その他、neovimのプラグイン管理にはvim-plug、zshのプラグイン管理にはzplugを使用しています。  
ghcupもインストールされるがhaskellを使わないようであればアンインストールしても構いません。（インストールスクリプト中でインストールしないを選ぶとスクリプトが止まってしまうので注意）

## OS毎のインストール方法

### OS共通
1. wslのインストール
```powershell:powershell
wsl --install
```
上記をpowershellにて実行

### Ubuntu
2. ターミナルにてプロンプトに沿ってユーザー設定を進める

3. dotfilesをgitを使ってダウンロード→実行
```bash:bash
bash -c "$(curl -L raw.github.com/KK-Konbannha/dotfiles/main/install.sh)" -s init
```
上記をbashにて実行

### Arch Linux
2. [ArchWSL](https://github.com/yuk7/ArchWSL)に従ってArch Linuxをインストール

3. Arch Linuxのユーザー設定
```powershell:powershell
Arch.exe
passwd
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd -m -G wheel -s /bin/bash {username}
passwd {username}
exit
Arch.exe config --dafault-user {username}
```
上記をpowershellにて実行

4. dotfilesをダウンロード→実行
```bash:bash
bash -c "$(curl -L raw.github.com/KK-Konbannha/dotfiles/main/install.sh)" -s init
```
上記をbashにて実行
