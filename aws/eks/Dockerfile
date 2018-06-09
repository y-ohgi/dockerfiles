FROM python:3

WORKDIR /root

ENV KUBECONFIG "/root/.kube/config"

COPY ./scripts /opt/scripts

RUN pip install awscli && \
    apt update && \
    apt install -y curl groff-base less jq git && \
    git clone https://github.com/ahmetb/kubectx /opt/kubectx && \
    ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && \
    ln -s /opt/kubectx/kubens /usr/local/bin/kubens && \
    cd /usr/local/bin && \
    curl -LO https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh && \
    echo 'source /usr/local/bin/kube-ps1.sh && export PS1="\$(kube_ps1) \w # "' >> /root/.bashrc && \
    curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws && \
    chmod +x ./heptio-authenticator-aws && \
    curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mkdir -p /root/.kube && { \
      echo 'apiVersion: v1'; \
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
      echo 'current-context: aws'; \
      echo 'kind: Config'; \
      echo 'preferences: {}'; \
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
    } | tee /root/.kube/config
