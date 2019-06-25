FROM amazonlinux:2

ENV KUBECTL_VERSION=v1.14.3
ENV STERN_VERSION=1.10.0
ENV COMPOSE_VERSION=1.24.0

WORKDIR /app

RUN set -x \
  && yum install -y tar gzip awscli git jq which \
  && amazon-linux-extras install -y docker \
  && systemctl enable docker.service \
  && curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose \
  && curl https://bootstrap.pypa.io/get-pip.py | python \
  && curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
  && mv /tmp/eksctl /usr/local/bin \
  && curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator \
  && chmod +x /usr/local/bin/aws-iam-authenticator \
  && git clone https://github.com/ahmetb/kubectx /tmp/kubectx \
  && mv /tmp/kubectx/kubectx /usr/local/bin/kubectx \
  && mv /tmp/kubectx/kubens /usr/local/bin/kubens \
  && curl -L -o /usr/local/bin/kube-ps1.sh https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh \
  && curl -L -o /usr/local/bin/stern https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64 && chmod +x /usr/local/bin/stern \
  && echo 'export LC_ALL="C.UTF-8"' >> /root/.bashrc \
  && echo '. /usr/local/bin/kube-ps1.sh' >> /root/.bashrc \
  && echo 'export PS1=""' >> /root/.bashrc \
  && echo 'export PS1+="[\$(date +'\''%Y-%m-%dT%H:%M:%S%z'\'')] "'>> /root/.bashrc \
  && echo 'export PS1+="\$(kube_ps1) "' >> /root/.bashrc \
  && echo 'export PS1+="\w "' >> /root/.bashrc \
  && echo 'export PS1+="\\n# "' >> /root/.bashrc \
  && echo 'alias k="kubectl"' >> /root/.bashrc \
  && echo 'complete -C "/usr/bin/aws_completer" aws' >> /root/.bashrc \
  && rm -rf /tmp/*

CMD ["bash"]
