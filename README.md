# PlantSuite MES

## Kind

O **Kind** é um ferramenta para desenvolvimento e testes que roda clusters **Kubernetes** local usando containers Docker/Podman para a criação dos nodes. 

Informações e instruções de instalação: https://kind.sigs.k8s.io

Após instalação, você pode criar um cluster com 3 nós executando o comando abaixo:

```console
kind create cluster --config kind.yaml
```

## Istio - Ambient Mode

Istio está configurado para rodar em **Ambient Mode**.

Mais instruções em: https://istio.io/latest/docs/ambient/

## Kiali

Criar um token para acessar o Kiali.

```console
kubectl -n istio-system create token kiali-service-account
```

## PlantSuite Container Registry 

Nas pastas de serviços do PlantSuite, crie um arquivo com o nome de **plantsuite-acr.json** conforme exemplo abaixo:

```json
{
    "auths": {
        "plantsuite.azurecr.io": {
            "username": "seu-usuario",
            "password": "sua-senha"
        }
    }
}
```