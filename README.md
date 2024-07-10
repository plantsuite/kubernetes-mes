# PlantSuite MES

Repositório com exemplos para deploy dos serviços **PlantSuite MES** em **Kubernetes**.

## Como usar os exemplos?

Inicialmente, será necessário um cluster Kubernetes, você pode usar algum de sua preferência ou pode começar usando o [Kind](https://https://kind.sigs.k8s.io).

[Clone](https://docs.github.com/pt/repositories/creating-and-managing-repositories/cloning-a-repository) ou faça download dos arquivos desse repositório para o seu computador.

### Kind - Kubernetes local para testes

O **Kind** é um ferramenta para criação de clusters **Kubernetes** usando Docker ou Podman que irá criar conteiners para representar os nós do cluster.

A instalação é opcional, servindo como uma opção para facilitar testes locais.

Mais informações sobre uso e instalação na documentação oficial em https://kind.sigs.k8s.io/docs/user/quick-start/.

Após instalação, para criar um cluster simples, com apenas 1 nó, execute o comando abaixo:

```console
kind create cluster --name plantsuite
```

Você pode usar o exemplo `tests/kind-cluster.yaml` para criar um cluster com 3 nós.

```console
kind create cluster --config tests/kind-cluster.yaml
```

### Organização das pastas e geração de manifestos

Os arquivos e pastas estão organizadas seguindo o padrão de [overlays]([https://](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/#2-create-variants-using-overlays)) do [Kustomize](https://kustomize.io/).

Na pasta `apps` contém as pastas para cada aplicação e dentro delas sua respectiva pasta `base` que contém os arquivos com as definições padrões da aplicação.

Por exemplo, para verificar as definições `base` do RabbitMQ, execute o comando:

```console
kubectl kustomize apps/rabbitmq/base/
```
Caso a aplicação possua `overlays`, por exemplo, com configurações recomendadas para produção:

```console
kubectl kustomize apps/rabbitmq/overlays/production/
```

Os comandos acima irão exibir os manifestos no **console**, que é útil para verificação.
Mas se a saída for muito grande, talvez seja melhor salvar em arquivo para facilitar a visualização.

```console
kubectl kustomize apps/rabbitmq/overlays/production/ > rabbitmq-prd.yaml
```

### Instalar uma aplicação

Após verificar os manifestos gerados, você pode usar o `kubectl apply` para aplica-los no cluster.

Através da **saída do console**:

```console
kubectl kustomize apps/rabbitmq/overlays/production/ | kubectl apply -f -
```

Através de um **arquivo**:

```console
kubectl apply -f rabbitmq-prd.yaml
```
### PlantSuite Container Registry 

Antes de instalar as aplicações **PlantSuite**, informe o usuário e senha do **plantsuite.azurecr.io** no arquivo `/apps/base/plantsuite-acr/config.json`.

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

## Lista de comandos de instalação/atualização

Referências de comandos para instalação/atualização de cada aplicação.

### Cert-Manager

```console
kubectl kustomize apps/cert-manager/base/ --enable-helm | kubectl apply -f -
```

### Istio

```console
kubectl kustomize apps/istio/base/ --enable-helm | kubectl apply -f -
```
Istio está configurado para rodar em **Ambient Mode**.

Mais instruções em: https://istio.io/latest/docs/ambient/

### Kiali

```console
kubectl kustomize apps/kiali/base/ --enable-helm | kubectl apply -f -
```
Criar um token para acessar o Kiali.

```console
kubectl -n istio-system create token kiali-service-account
```

### kube-prometheus-stack

```console
kubectl kustomize apps/kube-prometheus-stack/base/ --enable-helm | kubectl apply -f --server-side -
```

### MongoDB

```console
kubectl kustomize apps/mongodb/base/ --enable-helm | kubectl apply -f -
```

### PlantSuite Base

***Executar antes de qualquer aplicação PlantSuite.***

```console
kubectl kustomize apps/plantsuite/base/ | kubectl apply -f -
```

### PlantSuite Account

```console
kubectl kustomize apps/plantsuite/account/base/ | kubectl apply -f -
```

### PlantSuite ControlStation

```console
kubectl kustomize apps/plantsuite/controlstation/base/ | kubectl apply -f -
```

### PlantSuite MES

```console
kubectl kustomize apps/plantsuite/mes/base/ | kubectl apply -f -
```

### PlantSuite Production

```console
kubectl kustomize apps/plantsuite/production/base/ | kubectl apply -f -
```

### PlantSuite Production

```console
kubectl kustomize apps/plantsuite/production/base/ | kubectl apply -f -
```