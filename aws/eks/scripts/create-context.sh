#!/bin/bash -e

export CLUSTER_NAME=${1:-sample-cluster}
export EKS_CLUSTER_ENDPINT_URL=$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.endpoint' --output text)
export EKS_CLUSTER_CREDENTIAL=$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.certificateAuthority.data' --output text)

cp /root/.kube/config.org /root/.kube/config

sed -i -e "s|server: <endpoint-url>|server: $EKS_CLUSTER_ENDPINT_URL|g" /root/.kube/config
sed -i -e "s|certificate-authority-data: <base64-encoded-ca-cert>|certificate-authority-data: $EKS_CLUSTER_CREDENTIAL|g" /root/.kube/config
sed -i -e "s|- \"<cluster-name>\"|- \"$CLUSTER_NAME\"|g" /root/.kube/config

cat ~/.kube/config
kubectl cluster-info
