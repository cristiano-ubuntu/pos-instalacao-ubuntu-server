## pos-instalacao-ubuntu-server
# Este script realiza as tarefas:

- Cria um script chamado atualiza.sh na pasta /bin e defina as permissões de execução para esse novo script;
- Atualiza o sistema;
- Instala do Docker;
- Instala do Composer;
- Instala do Portainer.

**Certifique-se de executar este script com privilégios de superusuário (geralmente usando sudo) para que ele tenha permissões para criar e modificar arquivos na pasta /bin.**

Para usar este script, você pode seguir estas etapas:

1 Abra um terminal no seu servidor Ubuntu.

2 Você precisará baixar o script do GitHub. Você pode usar o comando wget para fazer isso. Substitua seu_link pelo URL do raw do script no GitHub:

wget https://github.com/cristiano-ubuntu/pos-instalacao-ubuntu-server/raw/main/script.sh

1 Depois de baixar o script, você deve conceder permissão de execução a ele:
chmod +x script.sh

1 Agora você pode executar o script usando o seguinte comando:
./script.sh
Isso executará o script e iniciará o processo de instalação e configuração das ferramentas mencionadas no script.
Certifique-se de que você tenha os privilégios adequados para executar esses comandos, especialmente quando estiver instalando e configurando o Docker, pois isso pode exigir privilégios de superusuário (root).

