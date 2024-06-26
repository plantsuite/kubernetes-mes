# PlantSuite MES

Este repositório possui uma estrutura baseada em **Kustomize** e conjunto com uso de **Helm Charts**.

Referências:
- https://kustomize.io/
- https://helm.sh/
- https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/

## Kind

O **Kind** é um ferramenta para desenvolvimento e testes que roda clusters **Kubernetes** local usando containers Docker/Podman para a criação dos nodes. 

Informações e instruções de instalação: https://kind.sigs.k8s.io

Após instalação, você pode criar um cluster com 3 nós executando o comando abaixo:

```console
kind create cluster --config tests/kind-cluster.yaml
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

Informe o usuário e senha do **plantsuite.azurecr.io** no arquivo `/apps/base/plantsuite-acr/config.json`.

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