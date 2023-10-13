#!/bin/bash

# Atualizar pacotes
echo "Executando: sudo apt update -y"
sudo apt update -y

# Instalar pacotes
echo "Executando: sudo apt install xorg xfce4 xfce4-terminal -y"
sudo apt install xorg xfce4 xfce4-terminal -y

echo "Executando: sudo apt install python3 python3-pip zip git ffmpeg thunar-archive-plugin -y"
sudo apt install python3 python3-pip zip git ffmpeg thunar-archive-plugin -y

# Criar o script 'atualiza'
echo "Criando o script 'atualiza' em /.local/bin..."
sudo echo "sudo apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove && apt-get autoclean && apt-get clean" > ~/.local/bin/atualiza
chmod +x ~/.local/bin/atualiza

# Instalar e configurar o LightDM
echo "Executando: sudo apt install lightdm -y"
sudo apt install lightdm -y

echo "Movendo 50-unity-greeter.conf para 50-unity-greeter.conf.old..."
sudo mv /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf.old

echo "Editando 50-xfce-greeter.conf..."
sudo tee /usr/share/lightdm/lightdm.conf.d/50-xfce-greeter.conf <<EOL
[SeatDefaults]
greeter-session=unity-greeter
user-session=xfce

####

# Adiciona o repositório PPA do Mozilla Team
echo "Adicionando o repositório PPA do Mozilla Team..."
sudo add-apt-repository ppa:mozillateam/ppa -y

# Cria e adiciona as configurações de prioridade do Firefox no PPA
echo "Configurando a prioridade do Firefox no PPA..."
echo 'Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1' | sudo tee /etc/apt/preferences.d/mozillateamppa

# Configura atualizações automáticas
echo "Configurando atualizações automáticas..."
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# Atualiza os repositórios
echo "Atualizando os repositórios..."
sudo apt update

# Instala o Firefox
echo "Instalando o Firefox..."
sudo apt install firefox -y

####
# Exibir mensagem de conclusão
echo "Todas as instalações foram concluídas com sucesso! O sistema será reiniciado em 10 segundos..."
sleep 10

# Reiniciar o sistema
sudo reboot
