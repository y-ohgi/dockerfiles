FROM amazonlinux:2

RUN set -x \
  && yum install -y tar gzip awscli \
  && curl https://bootstrap.pypa.io/get-pip.py | python \
  && curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
  && mv /tmp/eksctl /usr/local/bin
