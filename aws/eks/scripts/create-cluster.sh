#!/bin/bash -e

####################
# How To Use
# `$ ./create-cluster.sh`
#
# Option
# * 第一引数に任意の文字列を渡してクラスター名を変更する
#   - `$ ./create-cluster.sh my-cluster`
# * 環境変数でリージョン情報を渡す
#   - `$ AWS_REGION=us-east-1 EKS_NODE_AMIID=ami-dea4d5a1 ./create-cluster.sh`


CLUSTER_NAME=${1:-sample-cluster}

#FIXME: regionとAMIバージョンに合わせて要修正
AWS_REGION=${AWS_REGION:-us-west-2} # Oregon(us-west-2)
EKS_NODE_AMIID=${EKS_NODE_AMIID:-ami-73a6e20b} # Oregon(us-west-2)

EKS_VPCID=""
EKS_SUBNETS=""

EKS_CLUSTER_SG=""
EKS_CLUSTER_ROLE=""

EKS_NODE_KEYPAIR=$CLUSTER_NAME
EKS_NODE_ROLE=""

# Authentication of aws command
set +e
aws sts get-caller-identity || aws configure
set -e
aws configure set region $AWS_REGION


# Create Cluster IAM Role
printf " ${COLOR_GRAY}Start Create Cluster IAM Role... ${COLOR_OFF}\n"

cat <<EOL > /tmp/policy.json
{
  "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            }
        }
    ]
}
EOL

aws iam create-role --role-name ${CLUSTER_NAME}-role --assume-role-policy-document file:///tmp/policy.json
aws iam attach-role-policy --role-name ${CLUSTER_NAME}-role --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
aws iam attach-role-policy --role-name ${CLUSTER_NAME}-role --policy-arn arn:aws:iam::aws:policy/AmazonEKSServicePolicy
EKS_CLUSTER_ROLE=$(aws iam get-role --role-name ${CLUSTER_NAME}-role --query 'Role.Arn' --output text)


# Create Cluster VPC
printf " ${COLOR_GRAY}Start Create VPC Stack... ${COLOR_OFF}\n"

aws cloudformation create-stack --stack-name ${CLUSTER_NAME} --template-url https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/amazon-eks-vpc-sample.yaml
aws cloudformation wait stack-create-complete --stack-name $CLUSTER_NAME
EKS_VPCID=$(aws cloudformation describe-stacks --stack-name $CLUSTER_NAME --query 'Stacks[0].Outputs[?OutputKey==`VpcId`][].OutputValue' --output text)
EKS_SUBNETS=$(aws cloudformation describe-stacks --stack-name $CLUSTER_NAME --query 'Stacks[0].Outputs[?OutputKey==`SubnetIds`][].OutputValue' --output text)
EKS_CLUSTER_SG=$(aws cloudformation describe-stacks --stack-name $CLUSTER_NAME --query 'Stacks[0].Outputs[?OutputKey==`SecurityGroups`][].OutputValue' --output text)


# Create EKS Cluster
printf " ${COLOR_GRAY}Start Create EKS Cluster... ${COLOR_OFF}\n"

aws eks create-cluster --name $CLUSTER_NAME --role-arn ${EKS_CLUSTER_ROLE} --resources-vpc-config subnetIds=${EKS_SUBNETS},securityGroupIds=${EKS_CLUSTER_SG}

while [ ! "$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.status' --output text)" = "ACTIVE" ]
do
  sleep 1
done

aws eks describe-cluster --name $CLUSTER_NAME
EKS_CLUSTER_ENDPINT_URL=$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.endpoint' --output text)
EKS_CLUSTER_CREDENTIAL=$(aws eks describe-cluster --name $CLUSTER_NAME --query 'cluster.certificateAuthority.data' --output text)


# Setting kubectl
printf " ${COLOR_GRAY}Setting kubectl... ${COLOR_OFF}\n"

sed -i -e "s|server: <endpoint-url>|server: $EKS_CLUSTER_ENDPINT_URL|g" /root/.kube/config
sed -i -e "s|certificate-authority-data: <base64-encoded-ca-cert>|certificate-authority-data: $EKS_CLUSTER_CREDENTIAL|g" /root/.kube/config
sed -i -e "s|- \"<cluster-name>\"|- \"$CLUSTER_NAME\"|g" /root/.kube/config


# Verify kubectl
kubectl get all

# Create Keypair
printf " ${COLOR_GRAY}Create Worker Node Keypair... ${COLOR_OFF}\n"

aws ec2 create-key-pair --key-name $EKS_NODE_KEYPAIR --query 'KeyMaterial' --output text > /tmp/$EKS_NODE_KEYPAIR.pem


# Create Worker Nodes
printf " ${COLOR_GRAY}Create Worker Node Group... ${COLOR_OFF}\n"

aws cloudformation create-stack \
    --stack-name ${CLUSTER_NAME}-nodegroup \
    --template-url https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/amazon-eks-nodegroup.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters \
    ParameterKey=ClusterName,ParameterValue=$CLUSTER_NAME \
    ParameterKey=NodeGroupName,ParameterValue=${CLUSTER_NAME}-nodegroup \
    ParameterKey=VpcId,ParameterValue=$EKS_VPCID \
    ParameterKey=Subnets,ParameterValue=\"$EKS_SUBNETS\" \
    ParameterKey=ClusterControlPlaneSecurityGroup,ParameterValue=$EKS_CLUSTER_SG \
    ParameterKey=KeyName,ParameterValue=$EKS_NODE_KEYPAIR \
    ParameterKey=NodeImageId,ParameterValue=$EKS_NODE_AMIID
aws cloudformation wait stack-create-complete --stack-name ${CLUSTER_NAME}-nodegroup
EKS_NODE_ROLE=$(aws cloudformation describe-stacks --stack-name test-cluster-nodegroup --query 'Stacks[0].Outputs[?OutputKey==`NodeInstanceRole`].OutputValue' --output text)


# Enable Worker Nodes
curl -sSL https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/aws-auth-cm.yaml | sed -e "s|rolearn: <ARN of instance role (not instance profile)>|rolearn: $EKS_NODE_ROLE|g" | kubectl apply -f -

sleep 10
kubectl get nodes

cat << EOL
    _                                     _____ _  ______
   / \   _ __ ___   __ _ _______  _ __   | ____| |/ / ___|
  / _ \ | '_ \` _ \ / _\` |_  / _ \| '_ \  |  _| | ' /\___ \\
 / ___ \| | | | | | (_| |/ / (_) | | | | | |___| . \ ___) |
/_/   \_\_| |_| |_|\__,_/___\___/|_| |_| |_____|_|\_\____/
EOL
