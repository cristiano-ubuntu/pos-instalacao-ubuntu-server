#!/bin/bash

# Atualizar pacotes
sudo apt update -y

# Instalar pacotes
sudo apt install xorg xfce4 xfce4-terminal -y
sudo apt install nano mousepad python3 python3-pip xarchiver catfish ffmpeg thunar-archive-plugin xfce4-whiskermenu-plugin alacarte smplayer audacious libreoffice gvfs gvfs-backends policykit-1 udisks2 rar unrar zip unzip simplescreenrecorder -y

# sudo apt install  policykit-1-gnome -y - comentei pq na linha de cima já instala o policykit-1

# Criar o script 'atualiza' em /usr/local/bin/
echo 'apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove && apt-get autoclean && apt-get clean' | sudo tee /usr/local/bin/atualiza

# Dá permissão de execução ao script atualiza
chmod +x /usr/local/bin/atualiza

# Adiciona o repositório PPA do Grub Customizer
sudo add-apt-repository ppa:danielrichter2007/grub-customizer

# Atualiza os repositório já com o do Grub Customizer
sudo apt update -y

# Instala o Grub Customizer
sudo apt install grub-customizer -y

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

# Atualiza os repositórios já com o do Firefox
sudo apt update -y

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
