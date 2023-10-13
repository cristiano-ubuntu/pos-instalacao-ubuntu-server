#!/bin/bash

# Atualizar pacotes
sudo apt update -y

# Instalar pacotes
sudo apt install xorg xfce4 xfce4-terminal -y
sudo apt install nano mousepad python3 python3-pip zip git ffmpeg thunar-archive-plugin -y

# Cria a pasta /.local/bin
mkdir ~/.local/bin

# Adicionando o diretório /.local/bin à variável de ambiente PATH
export PATH="$HOME/.local/bin:$PATH"

# Criar o script 'atualiza' em /.local/bin
sudo echo "sudo apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove && apt-get autoclean && apt-get clean" > ~/.local/bin/atualiza
chmod +x ~/.local/bin/atualiza

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
