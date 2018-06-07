FROM python:3-alpine

RUN pip install awscli && \
    apk add --update curl groff less jq && \
    cd /usr/local/bin && \
    curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws && \
    chmod +x ./heptio-authenticator-aws && \
    curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mkdir /root/.kube && { \
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

ENV KUBECONFIG "/root/.kube/config"
