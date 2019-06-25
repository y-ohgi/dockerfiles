yohgi/awscli
---

[yohgi/awscli - Docker Hub](https://hub.docker.com/r/yohgi/awscli)

# About
AWSの操作に必要そうなツール群

# How To Use

```
$ aws configure
$ docker run \
  -v $HOME/.aws:/root/.aws \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -it \
  aws
```

# Tools
インストール済みのコマンド

* awscli
    - [AWS Command Line Interface](https://aws.amazon.com/cli/)
    - AWSサービスを操作を行う
* Docker
    - [Enterprise Container Platform | Docker](https://www.docker.com/)
    - Docker CLI
* kubectl
    - [kubernetes/pkg/kubectl at master · kubernetes/kubernetes](https://github.com/kubernetes/kubernetes/tree/master/pkg/kubectl)
    - Kubernetesの操作を行う
* ekscli
    - [weaveworks/eksctl: a CLI for Amazon EKS](https://github.com/weaveworks/eksctl)
    - EKSを簡単に操作するためのコマンド
* jq
    - [stedolan/jq: Command-line JSON processor](https://github.com/stedolan/jq)
    - JSONの整形や操作を行う
* kubectx
    - [ahmetb/kubectx: Fast way to switch between clusters and namespaces in kubectl!](https://github.com/ahmetb/kubectx)
    - Kubernetesのcontextの表示や操作を行う
* kubens
    - [ahmetb/kubectx: Fast way to switch between clusters and namespaces in kubectl!](https://github.com/ahmetb/kubectx)
    - Kubernetesのnamespaceの表示や操作を行う
* helm
    - [Helm - The Kubernetes Package Manager](https://www.helm.sh/)
    - いわゆるKubernetesのパッケージマネージャ
* kube_ps1
    - [jonmosco/kube-ps1: Kubernetes prompt info for bash and zsh](https://github.com/jonmosco/kube-ps1)
    - 現在ログインしているKubernetesのcontext/namespaceを表示する
* stern
    - [wercker/stern: ⎈ Multi pod and container log tailing for Kubernetes](https://github.com/wercker/stern)
    - 複数Podのログをマージしてtailを行う
