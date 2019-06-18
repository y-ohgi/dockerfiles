ekscli
---

<img src="https://raw.githubusercontent.com/y-ohgi/dockerfiles/master/aws/ekscli/docs/ekscli.png" width="100%" />

# About
Amazon EKS を便利に触るためのコマンド群

# How to Start
## imageの実行
[yohgi/ekscli](https://hub.docker.com/r/yohgi/ekscli) のイメージを実行し、コンテナawsのアクセスキーを取得する。
```
$ docker run -it yohgi/ekscli bash
# aws configure
AWS Access Key ID [None]: <YOUR ACCESS KEY>
AWS Secret Access Key [None]: <YOUR SECRET KEY>
Default region name [None]: ap-northeast-1
Default output format [None]: json

```

既存のホスト上のアクセスキーを使用する場合はマウントを行う。
```console
$ docker run -it -v $HOME/.aws:/root/.aws yohgi/ekscli bash
```

## クラスタの認証情報を取得する
```
$ aws eks update-kubeconfig --name <YOUR CLUSTER NAME>
```

# Tips
## 新しくEKSクラスタを作成する場合
```
eksctl create cluster \
  --name prod \
  --version 1.12 \
  --nodegroup-name standard-workers \
  --node-type t3.medium \
  --nodes 3 \
  --nodes-min 1 \
  --nodes-max 4 \
  --node-ami auto
```

# Tools
インストール済みのコマンド

* awscli
    - [AWS Command Line Interface](https://aws.amazon.com/cli/)
    - AWSサービスを操作を行う
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

