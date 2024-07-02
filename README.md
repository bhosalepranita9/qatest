Step 1: Setting Up Kubernetes Cluster
Install Minikube (if not already installed):

Follow the official documentation for Minikube installation.
Start Minikube:
minikube start


Step 2: Deploying Services to Kubernetes
Assuming you have Docker images for your frontend and backend services:

Create Kubernetes Deployment manifests:

Write deployment.yaml files for both frontend and backend services.

1.Create Kubernetes Deployment manifests:

Write deployment.yaml files for both frontend and backend services

apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: your-frontend-image:tag
        ports:
        - containerPort: 80

backend-deployment.yaml:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: backend
        image: your-backend-image:tag
        ports:
        - containerPort: 8080

	
2. Apply the Deployments:
kubectl apply -f frontend-deployment.yaml
kubectl apply -f backend-deployment.yaml

3. Expose Services (if not using an Ingress controller):

You can use kubectl expose or NodePort for simplicity in a local setup.

Step 3: Verification
1. Check Pods and Services:

kubectl get pods
kubectl get services

2.Ensure frontend can communicate with backend:

The frontend should be configured to reach the backend service using Kubernetes DNS (http://backend:8080 if using service discovery).

Access Frontend URL:

3.Determine the frontend service URL (minikube service frontend --url) and verify it displays the expected output from the backend.

Step 4: Automated Testing
1.Write a Test Script:

Use a tool like curl, wget, or a scripting language (e.g., Bash, Python) to verify the integration between frontend and backend.

Bash script (test.sh):
#!/bin/bash

FRONTEND_URL=$(minikube service frontend --url)
EXPECTED_MESSAGE="Hello from backend!"

ACTUAL_MESSAGE=$(curl -s $FRONTEND_URL)

if [[ "$ACTUAL_MESSAGE" == *"$EXPECTED_MESSAGE"* ]]; then
    echo "Integration test passed: Frontend correctly displays backend message."
    exit 0
else
    echo "Integration test failed: Frontend does not display expected backend message."
    exit 1
fi

2. Make the script executable:

chmod +x test.sh

3. Run the Test Script:

./test.sh



