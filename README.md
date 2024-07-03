Step 1: Setting up the Kubernetes Cluster (Minikube Example)

Install Minikube:

Follow the official installation guide for Minikube.

Ensure kubectl is also installed as it will be used to interact with Kubernetes.
Start Minikube:

Open a terminal and start Minikube
minikube start

Step 2: Deploying Services to Kubernetes
Clone the Repository:

Clone the GitHub repository containing the services:
git clone https://github.com/Vengatesh-m/qa-test
cd qa-test

Deploy Backend and Frontend:

Review the Kubernetes manifests (deployment.yaml, service.yaml) in the repository.
Deploy the backend and frontend services using kubectl:
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml

Verify Deployment:

Check that all pods are running:
kubectl get pods

Verify services are created:
kubectl get services

Ensure deployments are ready:
kubectl get deployments


Step 3: Verification
Communication Between Services:

Check logs to verify frontend can access backend
kubectl logs <frontend-pod-name>

Access Frontend URL:

Use Minikube to get the frontend URL:
minikube service <frontend-service-name>


Step 4: Automated Testing
Create a Python script (test_integration.py) to verify frontend-backend integration:

import requests

frontend_url = "<frontend-service-url>"
expected_message = "Hello from backend!"

response = requests.get(frontend_url)
assert response.status_code == 200
assert expected_message in response.text

print("Integration test passed successfully!")

