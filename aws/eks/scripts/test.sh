#!/bin/bash

CLUSTER_NAME=sample-cluster
CLUSTER_NAME=test-cluster

start=$(date +%N)

sleep 2

end=$(date +%N)

echo `echo (end - start)/1000000000`


cat << EOL > /dev/null
$ /opt/scripts/create-context.sh

clusters=(aws eks list-clusters ...リージョン分)

target=$(echo clusters | fzf)
>
ap-northeast-1 sample-cluster
us-east-1 microservice-cluster
us-west-2 sample-cluster
us-west-2 microservice-cluster



export CLUSTER_NAME=$(target)
export EKS_CLUSTER_ENDPINT_URL=$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.endpoint' --output text)
export EKS_CLUSTER_CREDENTIAL=$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.certificateAuthority.data' --output text)

kubectl config set-cluster $CLUSTER_NAME --server=$EKS_CLUSTER_ENDPINT_URL --certificate-authority=$EKS_CLUSTER_CREDENTIAL
kubectl config set-context $CLUSTER_NAME --cluster=$CLUSTER_NAME --user=${CLUSTER_NAME}-user
kubectl config set-credentials ${CLUSTER_NAME}-user

sed -i "/^\- name: ${CLUSTER_NAME}\-user/a\ \ user:\n\
    exec:\n\
    apiVersion: client.authentication.k8s.io/v1alpha1\n\
    command: heptio-authenticator-aws\n\
    args:\n\
      - \"token\"\n\
      - \"-i\"\n\
      - \"${CLUSTER_NAME}\"" $([[ -n "$KUBECONFIG" ]] && echo ${KUBECONFIG%%:*} || ~/.kube/config )
EOL


# start_time=`date +%s`

# aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.status' --output text

# end_time=`date +%s`

# time=$((end_time - start_time))

# echo $time




# while [ ! "$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.status' --output text)" = "CREATING" ]
# do
#   # eks_status=$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.status' --output text)

#   # [[ "${eks_status}" = "ACTIVE" ]] && echo 'done' && break

#   echo -n .
#   sleep 1
# done
