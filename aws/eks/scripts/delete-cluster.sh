#!/bin/bash

####################
# How To Use
# `$ ./delete-cluster.sh`
#
# Option
# * 第一引数に任意の文字列を渡してクラスター名を変更する
#   - `$ ./delete-cluster.sh my-cluster`
# * 環境変数でリージョン情報を渡す
#   - `$ AWS_REGION=us-east-1 EKS_NODE_AMIID=ami-dea4d5a1 ./create-cluster.sh`


CLUSTER_NAME=${1:-sample-cluster}

#FIXME: regionとAMIバージョンに合わせて要修正
AWS_REGION=${AWS_REGION:-us-west-2} # Oregon

COLOR_RED="\e[0;31m"
COLOR_GRAY="\e[0;90m"
COLOR_OFF="\e[0m"

CMD_DELETE_CFN_NODEGROUP=$(echo aws cloudformation delete-stack --stack-name ${CLUSTER_NAME}-nodegroup)
CMD_DELETE_KEYPAIR=$(echo aws ec2 delete-key-pair --key-name ${CLUSTER_NAME})
CMD_DELETE_EKS_CLUSTER=$(echo aws eks delete-cluster --name ${CLUSTER_NAME})
CMD_DELETE_VPC=$(echo aws cloudformation delete-stack --stack-name ${CLUSTER_NAME})
CMD_DELETE_EKS_ROLE=$(echo aws iam delete-role --role-name ${CLUSTER_NAME}-role)

printf "> ${COLOR_RED}削除を実行しても問題ありませんか？${COLOR_OFF}\n"
echo "実行されるコマンド"

printf " ${COLOR_GRAY}${CMD_DELETE_CFN_NODEGROUP} ${COLOR_OFF}\n"
printf " ${COLOR_GRAY}${CMD_DELETE_KEYPAIR} ${COLOR_OFF}\n"
printf " ${COLOR_GRAY}${CMD_DELETE_EKS_CLUSTER} ${COLOR_OFF}\n"
printf " ${COLOR_GRAY}${CMD_DELETE_VPC} ${COLOR_OFF}\n"
printf " ${COLOR_GRAY}${CMD_DELETE_EKS_ROLE} ${COLOR_OFF}\n"

read -p "ok? (yes/no): " answer
[ "$answer" != "yes" ] && printf "${COLOR_RED}デプロイを中止します.${COLOR_OFF}\n" && exit

# cfn del nodegroup
eval $CMD_DELETE_CFN_NODEGROUP
aws cloudformation wait stack-delete-complete --stack-name ${CLUSTER_NAME}-nodegroup

# ec2 del keypair
eval $CMD_DELETE_KEYPAIR

# eks del cluster
eval $CMD_DELETE_EKS_CLUSTER
while [ $(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.status' --output text 2> /dev/null) ]
do
  sleep 1
done

# iam del role
aws iam list-attached-role-policies --role-name ${CLUSTER_NAME}-role --query 'AttachedPolicies[].PolicyArn' --output text | tr '\t' '\n' | xargs -I{} aws iam detach-role-policy --role-name ${CLUSTER_NAME}-role --policy-arn {}
eval $CMD_DELETE_EKS_ROLE

# cfn del vpc
eval $CMD_DELETE_VPC
aws cloudformation wait stack-delete-complete --stack-name ${CLUSTER_NAME}

echo Complete!!
