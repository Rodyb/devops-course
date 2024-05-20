#!/bin/bash

# Precondition have AWS CLI installed

# Vars
KEY_NAME="MyKeyPair"
SECURITY_GROUP_NAME="MySecurityGroup"
INSTANCE_TYPE="t2.micro"
IMAGE_ID="ami-0abcdef1234567890"
USER_NAME="MyUserCli"
GROUP_NAME="MyGroupCli"
POLICY_ARN="arn:aws:iam::aws:policy/AmazonEC2FullAccess"

# Create SSH Key Pair
echo "Creating SSH Key Pair..."
aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text > $KEY_NAME.pem
chmod 400 $KEY_NAME.pem

# Create Security Group
echo "Creating Security Group..."
GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "My security group" --query 'GroupId' --output text)
aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0

# Launch an EC2 Instance
echo "Launching EC2 Instance..."
aws ec2 run-instances --image-id $IMAGE_ID --count 1 --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --security-group-ids $GROUP_ID

# Create IAM User
echo "Creating IAM User..."
aws iam create-user --user-name $USER_NAME

# Create IAM Group
echo "Creating IAM Group..."
aws iam create-group --group-name $GROUP_NAME

# Attach Policy to Group
echo "Attaching Policy to Group..."
aws iam attach-group-policy --group-name $GROUP_NAME --policy-arn $POLICY_ARN

# Add User to Group
echo "Adding User to Group..."
aws iam add-user-to-group --group-name $GROUP_NAME --user-name $USER_NAME

# List AWS Resources
echo "Listing EC2 Instances:"
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, State.Name, InstanceType]" --output table

echo "Listing IAM Users:"
aws iam list-users

