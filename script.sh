#!/bin/bash

# Criação do script atualiza.sh
echo "Criando o script atualiza.sh em /bin..."
echo "apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove && apt-get autoclean && apt-get clean" > /bin/atualiza.sh
chmod +x /bin/atualiza.sh

# Atualizar o sistema
echo "Atualizando o sistema..."
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y

# Instalação do Docker
echo "Instalando o Docker..."
apt update
apt install apt-transport-https openssh-server nano curl wget gnupg-agent ca-certificates software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io -y
docker --version
systemctl status docker
systemctl start docker
systemctl enable docker
groupadd docker
#usermod -aG docker $USER
usermod -aG docker cristiano

# Instalação do Composer
echo "Instalando o Composer..."
curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Instalação do Portainer
echo "Instalando o Portainer..."
apt update -y && apt upgrade -y
docker volume create portainer_data
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

echo "Todas as instalações foram concluídas com sucesso!"
