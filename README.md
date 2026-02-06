# CI/CD Pipeline for Flask Application on AWS EKS

This project demonstrates an end-to-end **Infrastructure as Code + CI/CD + Kubernetes** workflow on AWS using Terraform and Jenkins.

It provisions cloud infrastructure automatically, builds a containerized application, pushes images to ECR, and deploys them to an Amazon EKS cluster through an automated Jenkins pipeline triggered by GitHub webhooks.

---

## 🚀 Architecture Overview

The solution consists of four major components:

### 1️⃣ Infrastructure (Terraform)
Terraform provisions the following AWS resources:

- **VPC** with public subnets across two availability zones  
- Internet Gateway and route tables  
- **Amazon EKS Cluster** with managed node group  
- **Amazon ECR repository** for container images  
- **Jenkins EC2 instance** with:
  - Docker  
  - AWS CLI  
  - kubectl  
  - IAM role-based access (no hardcoded credentials)  
- Security groups for secure access

Everything is created using a single Terraform configuration (`main.tf`).

---

### 2️⃣ Application

A simple Python Flask application is containerized using Docker.

Key files:
app/
├── app.py
├── Dockerfile
└── requirements.txt


The app listens on port **5000** inside the container.

---

### 3️⃣ CI/CD Pipeline (Jenkins)

Jenkins runs on an EC2 instance bootstrapped via **user-data script**.

The pipeline performs:

1. Checkout code from GitHub  
2. Build Docker image  
3. Authenticate to AWS ECR  
4. Push image to ECR  
5. Update EKS kubeconfig  
6. Deploy to EKS using Kubernetes manifests  

Pipeline file: `Jenkinsfile`

---

### 4️⃣ Kubernetes Deployment

The application is deployed to EKS using:

k8s/
├── deployment.yaml
└── service.yaml


- Uses a **LoadBalancer Service** to expose the app publicly  
- Runs as a replicated Deployment inside the cluster  

---

## 🔁 GitHub Webhook Automation

The pipeline is automatically triggered on every push to the `main` branch via a GitHub webhook:

GitHub push → Jenkins → ECR → EKS

---

## 🛠️ Tech Stack

| Layer | Technology |
|------|------------|
| Cloud | AWS |
| IaC | Terraform |
| CI/CD | Jenkins |
| Container | Docker |
| Registry | Amazon ECR |
| Orchestration | Kubernetes (EKS) |
| Source Control | GitHub |
| App | Python Flask |

---

## ▶️ How to Run (High Level)

1. Clone this repository  
2. Create an AWS key pair named `ci-cd-key`  
3. Run:
terraform init
terraform apply
4. Access Jenkins at:
http://<ec2-public-ip>:8080
5. Configure GitHub webhook:
http://<ec2-public-ip>:8080/github-webhook/

6. Push to `main` — the pipeline runs automatically 🚀

---

## 👤 Author
**Aniket Kasurde**  

