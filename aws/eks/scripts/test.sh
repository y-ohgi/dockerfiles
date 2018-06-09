#!/bin/bash

CLUSTER_NAME=sample-cluster
CLUSTER_NAME=test-cluster

start=$(date +%N)

sleep 2

end=$(date +%N)

echo `echo (end - start)/1000000000`


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
