# udacity-devops-capstone
#
# ############################
# Local
# ############################
#
# Front-end:
Location: ~/frontend
Build image:
- docker build -t duyhuynhdn/capstone-frontend:latest .
Push image:
- docker push duyhuynhdn/capstone-frontend:latest 

# Kubernates:
Start with minikube (required install minikube):
- minikube start
- kubectl apply -f capstone-frontend-deployment.yml
- kubectl apply -f capstone-frontend-service.yml

For local test:
- kubectl port-forward deployment/capstone-frontend 8080:80

# ############################
# AWS
# ############################
#
# 1. Create IAM User with "Administrator Access" privilege
# Configure: 
- aws configure --profile default
# Check: 
- aws iam list-users
- aws configure list
# 2. Create infrastructure
- cd /infrastructure
- aws cloudformation create-stack --stack-name Udacity-Capstone --template-body file://capstone-infra.yml  --parameters file://capstone-infra-parameters.json --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region=us-east-1
- aws cloudformation update-stack  --stack-name Udacity-Capstone --template-body file://capstone-infra.yml  --parameters file://capstone-infra-parameters.json --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region=us-east-1
- aws cloudformation describe-stacks --stack-name Udacity-Capstone
- aws cloudformation delete-stack --stack-name Udacity-Capstone
# deploy
- aws cloudformation deploy --stack-name Udacity-Capstone --template-body file://capstone-infra.yml  --parameters file://capstone-infra-parameters.json --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region=us-east-1
# Config kubectl
- aws eks update-kubeconfig --region us-east-1 --name EKSClusterCapstone
# Test kubectl
- kubectl get svc
# 3. Deployment eks service
- kubectl apply -f capstone-frontend-deployment.yml
- kubectl apply -f capstone-frontend-service.yml

# 99. Other
# Create eks by command
aws eks create-cluster --region us-east-1 --name EKSClusterCapstone --kubernetes-version 1.23 --role-arn arn:aws:iam::292969757732:role/eksClusterRole --resources-vpc-config subnetIds=subnet-0518ad0b4026fe2f1,subnet-07f96a6bec96815d4,securityGroupIds=sg-0d1bbdd80bc24b2df