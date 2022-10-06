# udacity-devops-capstone
#
# ############################
# Local
# ############################
#
# Front-end:
Location: ~/frontend
Build image:
- docker build -t duyhuynhdn/capstone-frontend:v1 .
Push image:
- docker push duyhuynhdn/capstone-frontend:v1 

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
# Config kubectl
- aws eks update-kubeconfig --region us-east-1 --name EKSClusterCapstone
# Test kubectl
- kubectl get svc
# 3. Deployment eks service
- kubectl apply -f capstone-frontend-deployment.yml
- kubectl apply -f capstone-frontend-service.yml