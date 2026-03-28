#  TaskOps — DevOps Project 

> 3-tier Microservices app with Git, CI/CD (Jenkins + GitHub Actions), Docker, Kubernetes, Terraform & Ansible

---

## 📁 Project Structure

```
devops-project/
├── frontend/               
│   ├── index.html
│   └── Dockerfile
├── backend/                
│   ├── app.py
│   ├── requirements.txt
│   ├── test_app.py
│   └── Dockerfile
├── jenkins/
│   └── Jenkinsfile         
├── terraform/              
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── ansible/                
│   ├── playbook.yml
│   └── inventory.ini
├── k8s/                    
│   └── deployment.yaml
├── .github/
│   └── workflows/
│       └── ci-cd.yml       
├── docker-compose.yml      
├── prometheus.yml          
└── README.md
```

---

## STEP 1 — Git Setup 

```bash
# Clone or init
git init
git remote add origin https://github.com/YOUR_USERNAME/devops-project.git

# Create feature branches (SHOW THESE IN VIVA)
git checkout -b feature/frontend
git add frontend/
git commit -m "feat: add React-style task manager UI"
git push origin feature/frontend

git checkout -b feature/backend
git add backend/
git commit -m "feat: add Flask REST API with MongoDB"
git push origin feature/backend

git checkout -b feature/docker
git add docker-compose.yml frontend/Dockerfile backend/Dockerfile
git commit -m "feat: dockerize all services with compose"
git push origin feature/docker

# Merge via Pull Requests on GitHub (do this in browser!)
git checkout main
git merge feature/frontend
git merge feature/backend
git merge feature/docker
git push origin main
```


---

## STEP 2 — Run Locally (Test First)

```bash
# Run everything with one command
docker-compose up --build

# Access:
# Frontend  → http://localhost
# Backend   → http://localhost:5000
# Health    → http://localhost:5000/health
# Grafana   → http://localhost:3000   (admin/admin)
# Prometheus→ http://localhost:9090
```

---

##  STEP 3 — Jenkins CI/CD Pipeline 

### Install Jenkins (on your machine or VM):
```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts
```

### Setup:
1. Open http://localhost:8080
2. Install plugins: Git, Docker, Pipeline
3. Add DockerHub credentials (ID: `dockerhub-creds`)
4. Create Pipeline job → point to `jenkins/Jenkinsfile`
5. Click **Build Now**

### Pipeline stages shown in Jenkins:
```
Clone → Test → Docker Build → Docker Push → Deploy → Health Check
```

---

## STEP 4 — Terraform — Infrastructure as Code 

```bash
cd terraform

# Initialize
terraform init

# Preview changes
terraform plan

# Create EC2 instance (installs Docker automatically!)
terraform apply

# See output (public IP)
terraform output

# Destroy when done
terraform destroy
```


---

##  STEP 5 — Ansible Deploy (Alternative IaC)

```bash
cd ansible

# Edit inventory.ini with your server IP

# Run deployment
ansible-playbook -i inventory.ini playbook.yml

# What it does:
# ✓ Installs Docker
# ✓ Clones repo
# ✓ Runs docker-compose
# ✓ Verifies health check
```

---

##  STEP 6 — Kubernetes with Minikube 

```bash
# Start Minikube
minikube start

# Deploy all services
kubectl apply -f k8s/deployment.yaml

# Check status
kubectl get pods
kubectl get services

# Access app
minikube service taskops-frontend

# Show in viva
kubectl get all


```
## Frontend Feature
This branch includes UI improvements for DeployHub dashboard.
# this 
    is
      my 
        devops 
            project
---



