## Create Kubernetes cluster
eksctl create cluster \
--name demo-cluster2 \
--version 1.27 \
--region eu-central-1 \
--nodegroup-name demo-nodes \
--node-type t2.small \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3