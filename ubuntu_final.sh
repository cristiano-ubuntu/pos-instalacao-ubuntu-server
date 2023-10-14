#!/bin/bash

# Atualizar pacotes
sudo apt update -y

# Instalar pacotes
sudo apt install xorg xserver-xorg-input-synaptics xfce4 xfce4-terminal -y
sudo apt install nano mousepad python3 python3-pip git xarchiver policykit-1-gnome catfish ffmpeg thunar-archive-plugin whisker-menu smplayer audacious libreoffice gvfs gvfs-backends policykit-1 udisks2 rar unrar zip unzip simplescreenrecorder -y

# Criar o script 'atualiza' em /usr/local/bin/
sudo echo "sudo apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove && apt-get autoclean && apt-get clean" > /usr/local/bin/atualiza
chmod +x /usr/local/bin/atualiza

# Adiciona o repositório PPA do Mozilla Team
sudo add-apt-repository ppa:mozillateam/ppa -y

# Cria e adiciona as configurações de prioridade do Firefox no PPA
echo 'Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozillateamppa

# Configura atualizações automáticas
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# Atualiza os repositórios
sudo apt update

# Instala o Firefox
sudo apt install firefox -y

# Instalar e configurar o LightDM
sudo apt install lightdm -y

# Movendo 50-unity-greeter.conf para 50-unity-greeter.conf.old...
sudo mv /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf.old

# Editando 50-xfce-greeter.conf...
echo '[SeatDefaults]
greeter-session=unity-greeter
user-session=xfce' | sudo tee /usr/share/lightdm/lightdm.conf.d/50-xfce-greeter.conf

# Espera 10 segundos para reiniciar o sistema
sleep 10

# Reiniciar o sistema
sudo reboot
