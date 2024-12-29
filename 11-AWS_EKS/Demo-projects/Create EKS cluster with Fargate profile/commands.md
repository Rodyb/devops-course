## Precondition 
- Have the EKS cluster

## Configure IAM Roles
- Create an AWS service
- Create usecase `Fargate pod`
- Add permissions `AmazonEKSFargatePodExecutionRolePolicy `
- Add role name `eks-fargate-role`

## Create Fargate profile
- Add a name: `dev-profile`
- Add `eks-fargate-role`

## Create namespace for Fargate
- Create namespace dev, this needs to match the yaml
- Add profile fargate also to the yaml

## Apply application 
- kubectl -f nginx-config.yaml