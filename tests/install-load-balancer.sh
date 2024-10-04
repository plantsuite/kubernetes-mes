#!/bin/bash

# Cloud Provider KIND
# https://kind.sigs.k8s.io/docs/user/loadbalancer/ 

VERSION="0.4.0"
FILENAME="cloud-provider-kind_${VERSION}_linux_amd64.tar.gz"

# download do arquivo
wget "https://github.com/kubernetes-sigs/cloud-provider-kind/releases/download/v${VERSION}/${FILENAME}"

# Verificar se o download foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Download concluído com sucesso."
else
    echo "Falha no download."
    exit 1
fi

# cria pasta de não existir
mkdir $VERSION

echo "Descompactando o arquivo..."
tar -xvzf $FILENAME -C $VERSION

# Verificar se a descompactação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Arquivo descompactado com sucesso em $VERSION."
else
    echo "Falha na descompactação."
    exit 1
fi

# instalando cloud-provider-kind
echo "Instalando cloud-provider-kind..."
install ${VERSION}/cloud-provider-kind /usr/local/bin

# Remover o arquivo baixado
echo "Removendo o arquivo baixado..."
rm $FILENAME

# Remover o diretório descompactado
echo "Removendo o diretório descompactado..."
rm -rf $VERSION

echo "Limpeza concluída."