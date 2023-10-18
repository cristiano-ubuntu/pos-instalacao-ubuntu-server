#!/bin/bash

# Atualizar pacotes
sudo apt update

# Instalar pacotes
sudo apt install xorg xfce4 xfce4-terminal -y
sudo apt install nano mousepad python3 python3-pip xarchiver catfish tumbler clipman ffmpeg thunar-archive-plugin xfce4-whiskermenu-plugin alacarte smplayer audacious libreoffice gvfs gvfs-backends policykit-1 udisks2 rar unrar zip unzip simplescreenrecorder -y

# sudo apt install  policykit-1-gnome -y - comentei pq na linha de cima já instala o policykit-1

# Cria a pasta /bin
mkdir -p ~/.local/bin

# Criar o script 'atualiza' em /.local/bin
echo 'apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove && apt-get autoclean && apt-get clean' | sudo tee ~/.local/bin/atualizar

# Adicionar a pasta ~/.local/bin ao PATH
export PATH="$PATH:$HOME/.local/bin"

# Dá permissão de execução ao script atualizar
sudo chmod +x /.local/bin/atualizar

# Adiciona o repositório PPA do Grub Customizer
sudo add-apt-repository ppa:danielrichter2007/grub-customizer/ppa -y

# Atualiza os repositório já com o do Grub Customizer
sudo apt update

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

# Espera 10 segundos
sleep 10

# Instala o lightdm-gtk-greeter-settings
sudo apt install lightdm-gtk-greeter-settings -y

# Espera 10 segundos para reiniciar o sistema
sleep 10

# Reiniciar o sistema
sudo reboot
