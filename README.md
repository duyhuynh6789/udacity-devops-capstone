# udacity-devops-capstone
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