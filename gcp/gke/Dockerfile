FROM google/cloud-sdk:slim

RUN set -x \
  && HELM_VERSION="v2.9.1" \
  && STERN_VERSION="1.6.0" \
  && JQ_VERSION="1.5" \
  && apt upgrade -y && apt update \
  && apt install -y vim bash-completion kubectl git \
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
  && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
  && yes y | ~/.fzf/install \
  && : "--- /root/.bashrc" \
  && cat /dev/null > /root/.bashrc \
  && echo '. /etc/bash_completion' >> /root/.bashrc \
  && echo '. <(kubectl completion bash)' >> /root/.bashrc \
  && echo '. /usr/local/bin/kube-ps1.sh' >> /root/.bashrc \
  && echo '# . ~/.fzf.bash' >> /root/.bashrc \
  && echo 'export PS1=""' >> /root/.bashrc \
  && echo 'export PS1+="[\$(date +'\''%Y-%m-%dT%H:%M:%S%z'\'')] "'>> /root/.bashrc \
  && echo 'export PS1+="\e[0;34mgcp:\$(cat /root/.config/gcloud/configurations/config_default | grep project | awk '\''{print \$3}'\'' | grep -e '\''.*'\'' || echo \"\e[0;90m project unselected\")\e[0m "' >> /root/.bashrc \
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
  && echo 'echo "* authorize GCP"' >> /root/.bashrc \
  && echo 'echo "  - $ gcloud auth login"' >> /root/.bashrc \
  && echo 'echo "* set default project"' >> /root/.bashrc \
  && echo 'echo "  - $ gcloud projects list"' >> /root/.bashrc \
  && echo 'echo "  - $ gcloud config set project <PROJECT ID>"' >> /root/.bashrc \
  && echo 'echo "* set default region"' >> /root/.bashrc \
  && echo 'echo "  - $ gcloud config set compute/zone asia-northeast1-a"' >> /root/.bashrc \
  && echo 'echo "* list existing clusters"' >> /root/.bashrc \
  && echo 'echo "  - $ gcloud container clusters list"' >> /root/.bashrc \
  && echo 'echo "* fetch Kubernetes credentials"' >> /root/.bashrc \
  && echo 'echo "  - $ gcloud container clusters get-credentials <CLUSTER NAME>"' >> /root/.bashrc \
  && echo 'echo "* list existing Kubernetes resources"' >> /root/.bashrc \
  && echo 'echo "  - $ kubectl get all"' >> /root/.bashrc \
  && echo 'echo "* rename current context"' >> /root/.bashrc \
  && echo 'echo "  - $ kubectx <NEW CONTEXT NAME>=."' >> /root/.bashrc \
  && echo 'echo "* change Kubernetes Namespace"' >> /root/.bashrc \
  && echo 'echo "  - $ kubens <NAMESPACE>"' >> /root/.bashrc \
  && echo 'echo ====================================================================================================' >> /root/.bashrc \
  && : "--- /root/.vimrc" \
  && echo 'set encoding=utf-8"' >> ~/.vimrc \
  && echo 'set fenc=utf-8"' >> ~/.vimrc \
  && echo ':syntax on"' >> ~/.vimrc \
  && : "--- clean cache" \
  && rm -rf /tmp/*

WORKDIR /root
CMD bash
