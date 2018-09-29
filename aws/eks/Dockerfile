#XXX: イメージはローカルに一度pullして終了の運用のため、軽量化するより利便性を求めて軽量ではないイメージを使用
FROM python:3

WORKDIR /root

ENV KUBECONFIG "/root/.kube/config"

COPY ./scripts /opt/scripts

RUN set -x \
  && KUBECTL_VERSION="1.10.3" \
  && AWS_KUBECTL_RELEASEDATE="2018-06-05" \
  && HELM_VERSION="v2.9.1" \
  && STERN_VERSION="1.6.0" \
  && JQ_VERSION="1.5" \
  && pip install awscli \
  && apt upgrade -y && apt update \
  && apt install -y curl bash-completion groff-base less jq git vim \
  && : "--- kubectl" \
  && curl -L -o /usr/local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/${AWS_KUBECTL_RELEASEDATE}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && : "--- heptio-authenticator-aws" \
  && curl -L -o /usr/local/bin/heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/${AWS_KUBECTL_RELEASEDATE}/bin/linux/amd64/heptio-authenticator-aws \
  && chmod +x /usr/local/bin/heptio-authenticator-aws \
  && : "--- kubectx & kubens" \
  && git clone https://github.com/ahmetb/kubectx /tmp/kubectx \
  && mv /tmp/kubectx/kubectx /usr/local/bin/kubectx \
  && mv /tmp/kubectx/kubens /usr/local/bin/kubens \
  && mv /tmp/kubectx/completion/kubectx.bash /etc/bash_completion.d/kubectx \
  && mv /tmp/kubectx/completion/kubens.bash /etc/bash_completion.d/kubens \
  && : "--- helm" \
  && curl -L https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar zxv -C /tmp \
  && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
  && : "--- kube_ps1" \
  && curl -L -o /usr/local/bin/kube-ps1.sh https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh \
  && : "--- stern" \
  && curl -L -o /usr/local/bin/stern https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64 && chmod +x /usr/local/bin/stern \
  && : "--- jq" \
  && curl -L -o /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 \
  && : "--- fzf" \
  && git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf \
  && yes y | /root/.fzf/install \
  && : "--- clean cache" \
  && rm -rf /tmp/* \
  && : "--- /root/.bashrc" \
  && cat /dev/null > /root/.bashrc \
  && echo '. /etc/bash_completion' >> /root/.bashrc \
  && echo '. <(kubectl completion bash)' >> /root/.bashrc \
  && echo '. /usr/local/bin/kube-ps1.sh' >> /root/.bashrc \
  && echo '# . ~/.fzf.bash' >> /root/.bashrc \
  && echo 'export PS1=""' >> /root/.bashrc \
  && echo 'export PS1+="[\$(date +'\''%Y-%m-%dT%H:%M:%S%z'\'')] "'>> /root/.bashrc \
  && echo 'export PS1+="\$(kube_ps1) "' >> /root/.bashrc \
  && echo 'export PS1+="\w "' >> /root/.bashrc \
  && echo 'export PS1+="\\n# "' >> /root/.bashrc \
  && echo 'export LC_ALL="C.UTF-8"' >> /root/.bashrc \
  && echo 'export HISTSIZE=500000' >> /root/.bashrc \
  && echo 'export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S"' >> /root/.bashrc \
  && echo 'export PATH="$PATH:/root/.fzf/bin"' >> /root/.bashrc \
  && echo 'export FZF_DEFAULT_OPTS="--height 40% --reverse --border --ansi"' >> /root/.bashrc \
  && echo 'alias rm="rm -i"' >> /root/.bashrc \
  && echo 'alias cp="cp -i"' >> /root/.bashrc \
  && echo 'alias mv="mv -i"' >> /root/.bashrc \
  && echo 'alias ls="ls --color=auto"' >> /root/.bashrc \
  && echo 'alias ll="ls -lat --color=always"' >> /root/.bashrc \
  && echo 'alias grep="grep --color"' >> /root/.bashrc \
  && echo 'alias ..="cd .."' >> /root/.bashrc \
  && echo 'alias d="docker"' >> /root/.bashrc \
  && echo 'alias k="kubectl"' >> /root/.bashrc \
  && echo "bind '\"\eh\": backward-kill-word'" >> /root/.bashrc \
  && echo 'echo ""' >> /root/.bashrc \
  && echo 'echo ====================================================================================================' >> /root/.bashrc \
  && echo 'echo Sample Commands.' >> /root/.bashrc \
  && echo 'echo ""' >> /root/.bashrc \
  && echo 'echo "* Create EKS Cluster"' >> /root/.bashrc \
  && echo 'echo "  - $ /opt/scripts/create-cluster.sh <CLUSTER_NAME>"' >> /root/.bashrc \
  && echo 'echo "* Delete EKS Cluster"' >> /root/.bashrc \
  && echo 'echo "  - $ /opt/scripts/delete-cluster.sh <CLUSTER_NAME>"' >> /root/.bashrc \
  && echo 'echo ""' >> /root/.bashrc \
  && echo 'echo "* list existing clusters"' >> /root/.bashrc \
  && echo 'echo "  - $ aws eks list-clusters"' >> /root/.bashrc \
  && echo 'echo "* If authenticating to an existing cluster"' >> /root/.bashrc \
  && echo 'echo "  - $ /opt/scripts/create-context.sh <CLUSTER_NAME>"' >> /root/.bashrc \
  && echo 'echo "* list existing Kubernetes resources"' >> /root/.bashrc \
  && echo 'echo "  - $ kubectl get all"' >> /root/.bashrc \
  && echo 'echo "* rename current context"' >> /root/.bashrc \
  && echo 'echo "  - $ kubectx <NEW CONTEXT NAME>=."' >> /root/.bashrc \
  && echo 'echo "* change Kubernetes Namespace"' >> /root/.bashrc \
  && echo 'echo "  - $ kubens <NAMESPACE>"' >> /root/.bashrc \
  && echo 'echo ====================================================================================================' >> /root/.bashrc \
  && : "--- /root/.vimrc" \
  && echo 'set encoding=utf-8"' >> /root/.vimrc \
  && echo 'set fenc=utf-8"' >> /root/.vimrc \
  && echo ':syntax on"' >> /root/.vimrc \
  &&  : "--- /root/.kube/config" \
  && mkdir -p /root/.kube && { \
      echo 'apiVersion: v1'; \
      echo 'kind: Config'; \
      echo 'preferences: {}'; \
      echo 'current-context: aws'; \
      echo 'clusters:';  \
      echo '- cluster:'; \
      echo '    server: <endpoint-url>'; \
      echo '    certificate-authority-data: <base64-encoded-ca-cert>'; \
      echo '  name: kubernetes'; \
      echo 'contexts:'; \
      echo '- context:'; \
      echo '    cluster: kubernetes'; \
      echo '    user: aws'; \
      echo '  name: aws'; \
      echo 'users:'; \
      echo '- name: aws'; \
      echo '  user:'; \
      echo '    exec:'; \
      echo '      apiVersion: client.authentication.k8s.io/v1alpha1'; \
      echo '      command: heptio-authenticator-aws'; \
      echo '      args:'; \
      echo '        - "token"'; \
      echo '        - "-i"'; \
      echo '        - "<cluster-name>"'; \
      echo '        # - "-r"'; \
      echo '        # - "<role-arn>"'; \
    } | tee /root/.kube/config.org

CMD bash
