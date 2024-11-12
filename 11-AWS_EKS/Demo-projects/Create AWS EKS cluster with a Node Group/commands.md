
## Configure IAM Roles
- Create an AWS Service
- Add EKS cluster in usecase
- Add AmazonEKSClusterPolicy permission
- Create a role: eks-cluster-role
---------
- Create an AWS service
- Add EC2 in usecase
- Add 3 policies, AmazonEKSWorkerNodePolicy, AmazonEC2ContainerRegistryReadOnly, AmazonEKS_CNI_Policy
- Create role: eks-node-group-role

## Create VPC in Cloudformation
- Create a stack from a template
- Create a stack name: eks-worker-node-vpc-stack
- Rest could be left as is.
- outputs: SecurityGroups, SubnetIds & VpcId. These are needed later on

## Create EKS Cluster
- Configure cluster: eks-cluster-test
- Add the eks-cluster-role
- Specify the VPC worker node that was created
- Specify the Security groups worker node that was created
- Set to public & private

## Connect kubectl with EKS cluster
- Create kubeconfig file `aws eks update-kubeconfig --name eks-cluster-test`

## Add node group to EKS Cluster
- Create node group `eks-node-group`
- Set image and on demand
- Set instance type to t3 small
- Set node group scaling configuration 
- Desired size 3
- Maximum size 4
- Add EC2 key pair