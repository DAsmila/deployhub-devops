# 🚀 TaskOps — DevOps Project (Full Marks Guide)

> 3-tier Microservices app with Git, CI/CD (Jenkins + GitHub Actions), Docker, Kubernetes, Terraform & Ansible

---

## 📁 Project Structure

```
devops-project/
├── frontend/               # HTML + Nginx (port 80)
│   ├── index.html
│   └── Dockerfile
├── backend/                # Flask REST API (port 5000)
│   ├── app.py
│   ├── requirements.txt
│   ├── test_app.py
│   └── Dockerfile
├── jenkins/
│   └── Jenkinsfile         # CI/CD pipeline
├── terraform/              # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── ansible/                # Configuration management
│   ├── playbook.yml
│   └── inventory.ini
├── k8s/                    # Kubernetes manifests
│   └── deployment.yaml
├── .github/
│   └── workflows/
│       └── ci-cd.yml       # GitHub Actions pipeline
├── docker-compose.yml      # All services together
├── prometheus.yml          # Monitoring config
└── README.md
```

---

## ✅ STEP 1 — Git Setup (CO2 — 8 Marks)

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

> 💡 **Viva tip**: Show the GitHub repo → Insights → Network to demonstrate branching.

---

## ✅ STEP 2 — Run Locally (Test First)

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

## ✅ STEP 3 — Jenkins CI/CD Pipeline (CO3 — 7 Marks)

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

## ✅ STEP 4 — Terraform — Infrastructure as Code (CO5 — 7 Marks)

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

> 💡 **What to show in viva**: `terraform apply` output with EC2 public IP, then open app in browser using that IP.

---

## ✅ STEP 5 — Ansible Deploy (Alternative IaC)

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

## ✅ STEP 6 — Kubernetes with Minikube (CO5 Bonus)

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

---

## 🏥 API Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/health` | Health check |
| GET | `/data` | Get all tasks |
| POST | `/data` | Add a task |
| DELETE | `/data/<name>` | Delete a task |

### Example:
```bash
# Health check
curl http://localhost:5000/health

# Add task
curl -X POST http://localhost:5000/data \
  -H "Content-Type: application/json" \
  -d '{"task": "Deploy to prod", "status": "pending"}'

# Get tasks
curl http://localhost:5000/data
```

---

## 🎯 Rubric Checklist

| Criteria | Marks | What to Show |
|----------|-------|--------------|
| Version Control | 8/8 | GitHub repo with feature branches + PRs + commit history |
| CI/CD Pipeline | 7/7 | Jenkins dashboard with all 6 stages green ✅ |
| Containerization | 8/8 | `docker ps` showing all 5 containers + Minikube pods |
| IaC | 7/7 | `terraform apply` output + `ansible-playbook` running |

---

## 🔥 Viva Talking Points

1. **"We used Git Flow"** — main, feature/frontend, feature/backend branches with PRs
2. **"End-to-end automation"** — push to GitHub → Jenkins triggers → tests run → Docker image built → deployed
3. **"Health check endpoint"** — `/health` used by Docker healthcheck AND Jenkins pipeline
4. **"Reproducible infra"** — `terraform apply` spins up a fresh server with Docker pre-installed
5. **"Monitoring included"** — Prometheus scrapes metrics, Grafana visualizes them
