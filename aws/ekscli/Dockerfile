FROM amazonlinux:2

RUN set -x \
  && yum install -y tar gzip awscli \
  && curl https://bootstrap.pypa.io/get-pip.py | python \
  && curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
  && mv /tmp/eksctl /usr/local/bin \
  && curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmox +x /usr/local/bin/kubectl
