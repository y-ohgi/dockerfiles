FROM google/cloud-sdk:slim

RUN apt upgrade -y && apt update && \
    apt install -y vim bash-completion jq kubectl git && \
    git clone https://github.com/ahmetb/kubectx /opt/kubectx && \
    ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && \
    ln -s /opt/kubectx/kubens /usr/local/bin/kubens && \
    ln -s /opt/kubectx/completion/kubectx.bash /etc/bash_completion.d/kubectx && \
    ln -s /opt/kubectx/completion/kubens.bash /etc/bash_completion.d/kubens && \
    curl -L -o /usr/local/bin/kube-ps1.sh https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh && \
    curl -L -o /usr/local/bin/stern https://github.com/wercker/stern/releases/download/1.6.0/stern_linux_amd64 && chmod +x /usr/local/bin/stern && \
    echo ". /etc/bash_completion" >> /root/.bashrc && \
    echo ". <(kubectl completion bash)" >> /root/.bashrc && \
    echo '. /usr/local/bin/kube-ps1.sh' >> /root/.bashrc && \
    echo 'export PS1="\$(cat /root/.config/gcloud/configurations/config_default | grep project | awk '\''{print \$3}'\'')"' >> /root/.bashrc && \
    echo 'export PS1+=" \$(kube_ps1) \w"' >> /root/.bashrc && \
    echo 'export PS1+=" # "' >> /root/.bashrc && \
    echo 'alias ls="ls --color=auto"' >> /root/.bashrc && \
    echo 'echo ====================================================================================================' >> /root/.bashrc && \
    echo 'echo Sample Commands.' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc && \
    echo 'echo "* authorize GCP"' >> /root/.bashrc && \
    echo 'echo "  - $ gcloud auth login"' >> /root/.bashrc && \
    echo 'echo "* list existing clusters"' >> /root/.bashrc && \
    echo 'echo "  - $ gcloud container clusters list"' >> /root/.bashrc && \
    echo 'echo "* fetch Kubernetes credentials"' >> /root/.bashrc && \
    echo 'echo "  - $ gcloud container clusters get-credentials <CLUSTER NAME>"' >> /root/.bashrc && \
    echo 'echo "* list existing Kubernetes resources"' >> /root/.bashrc && \
    echo 'echo "  - $ kubectl get all"' >> /root/.bashrc && \
    echo 'echo "* rename current context"' >> /root/.bashrc && \
    echo 'echo "  - $ kubectx <NEW CONTEXT NAME>=."' >> /root/.bashrc && \
    echo 'echo "* change Kubernetes Namespace"' >> /root/.bashrc && \
    echo 'echo "  - $ kubens <NAMESPACE>"' >> /root/.bashrc && \
    echo 'echo ====================================================================================================' >> /root/.bashrc

WORKDIR /root
CMD bash
