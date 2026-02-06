# 🚀 EKS CI/CD Project (Terraform + Jenkins)

This is an end-to-end DevOps project where I automated application deployment on AWS using **Terraform, Jenkins, Docker, and Kubernetes (EKS).**

The goal of this project was to build a real-world CI/CD pipeline similar to what is used in production environments.

---

## ✅ What I built

### ☁️ Infrastructure (Terraform)
Terraform automatically creates:

- VPC, Subnets, Route Tables, and Internet Gateway  
- EKS Cluster + Worker Nodes  
- ECR repository for Docker images  
- EC2 instance running Jenkins  
- Required IAM roles and security groups  

### 🤖 Jenkins Automation

Jenkins is installed automatically on EC2 using a **user-data script**, which includes:

- Jenkins  
- Docker  
- AWS CLI  
- kubectl  

No manual package installation is required.

### 🔁 CI/CD Pipeline

Jenkins pipeline does the following:

1. Pulls code from GitHub  
2. Builds a Docker image  
3. Pushes the image to AWS ECR  
4. Updates kubeconfig  
5. Deploys application to EKS using Kubernetes manifests  

### 🔔 GitHub Webhook

- Every push to the `main` branch automatically triggers the Jenkins pipeline.  
- No manual build needed.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| AWS | Cloud platform |
| Terraform | Infrastructure as Code |
| Jenkins | CI/CD automation |
| Docker | Containerization |
| EKS | Kubernetes cluster |
| ECR | Image registry |
| Kubernetes | App orchestration |
| GitHub | Source control |

---

## 🔄 High-Level Workflow

GitHub → Jenkins → Docker Build → ECR → EKS Deployment

## 👤 Author
**Aniket Kasurde**  